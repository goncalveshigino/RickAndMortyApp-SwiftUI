//
//  CharacterRepositoryTest.swift
//  RickAndMortyAppTests
//
//  Created by Goncalves Higino on 10/03/24.
//
import XCTest
@testable import RickAndMortyApp


class CharacterRepositoryTest: XCTestCase {
    
    var sut: CharacterRepository?
    var sutFailure: CharacterRepository?
    
    override func setUp() {
        super.setUp()
        sut = DefaultCharacterRepository()
        sutFailure = DefaultCharacterRepository()
    }
    
    override func tearDown() {
        sut = nil
        sutFailure = nil
        super.tearDown()
    }
}

//MARK: - Success Tests
extension CharacterRepositoryTest {
    func testSuccessCase_ResponseEntityIsNotNil() async {
        do {
            let response = try await sut?.getCharacterList(pageNumber: nil)
            XCTAssertTrue(response?.results.first?.id == 21)
        } catch {
            XCTFail("Always receive a response and not throw an error")
        }
    }
}

//MARK: - Failure Tests
extension CharacterRepositoryTest {
    func testFailureCase_ResponseEntityIsNilReceiveError() {
        
    }
}
