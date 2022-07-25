//
//  RecipeServiceTests.swift
//  RecipleaseTests
//
//  Created by Mickael PAYAN on 14/06/2022.
//

import XCTest
@testable import Reciplease

final class RecipeServiceTests: XCTestCase {
    
    // MARK: - Properties
    
    private var networkSessionMock: NetworkSessionMock!
    private var responseMock: EdamamResponseMock!
    
    // MARK: - Test Life Cycle
    
    override func setUpWithError() throws {
        responseMock = EdamamResponseMock()
        networkSessionMock = NetworkSessionMock(responseMock: responseMock)
    }
    
    override func tearDownWithError() throws {
        networkSessionMock = nil
        responseMock = nil
    }
    
    // MARK: - Methods
    
    func testGivenServiceIsUnavailable_WhenRequestSearch_ErrorIsThrown() {
        let expectation = expectation(description: "Failure to get data.")
        let service = RecipeService(session: networkSessionMock)
        let query = "Salmon"
        
        responseMock.response = EdamamResponseMock.invalidResponse
        responseMock.result = (
            .failure(.invalidURL(url: ""))
        )
        
        service.getRecipe(query) { result in
            guard case .failure(let error) = result else { return }
            XCTAssertTrue(error.isInvalidURLError)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testGivenServiceIsAvailable_WhenRequestSearch_ThenProvideResult() {
        let expectation = expectation(description: "Success to get data.")
        let service = RecipeService(session: networkSessionMock)
        let query = "Salmon"
        
        guard let responseMocked = responseMock.make() else { return }
        responseMock.response = EdamamResponseMock.validResponse
        responseMock.result = (
            .success(responseMocked)
        )
        
        service.getRecipe(query) { result in
            guard case .success(let recipe) = result else { return }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}
