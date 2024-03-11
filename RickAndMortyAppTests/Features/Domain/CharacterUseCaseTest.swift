//
//  CharacterUseCaseTest.swift
//  RickAndMortyAppTests
//
//  Created by Goncalves Higino on 11/03/24.
//

import XCTest
@testable import RickAndMortyApp


class CharacterUseCaseTest: XCTestCase {
    
    var sut: CharacterUseCase?
    var sutFailure: CharacterUseCase?
    
    override func setUp() {
        super.setUp()
        sut = DefaultCharacterUseCase(repository: DefaultCharacterRepository(apiService: CharacterListFakeApiServiceSuccess()))
        sutFailure = DefaultCharacterUseCase(repository: DefaultCharacterRepository(apiService: CharacterListFakeApiServiceFailure()))
        
    }
    
    override func tearDown() {
        sut = nil
        sutFailure = nil
        super.tearDown()
    }
}

//MARK: - Success Tests
extension CharacterUseCaseTest {
    func testSuccessCase_getCharacterList() async {
        do {
            let response = try await sut?.getCharacterList(pageName: nil)
            XCTAssertTrue(response?.results.first?.id == 21)
        } catch {
            XCTFail("Always receive a response and not throw an error")
        }
    }
    func testSuccessCase_searchCharacter() async {
        do {
            let response = try await sut?.searchCharacter(by: "Rick", and: nil)
            XCTAssertTrue(response?.results.first?.id == 21)
        } catch {
            XCTFail("Always receive a response and not throw an error")
        }
    }
}

//MARK: - Failure Tests
extension CharacterUseCaseTest {
    func testFailureCase_getCharacterList()  async {
        do {
            let _ = try await sutFailure?.getCharacterList(pageName: nil)
            XCTFail("This test should throw an error")
        } catch {
            // Test passed
        }
    }
    
    func testFailureCase_searchCharacter()  async {
        do {
            let _ = try await sutFailure?.searchCharacter(by: "Rick", and: nil)
            XCTFail("This test should throw an error")
        } catch {
            // Test passed
        }
    }
}
