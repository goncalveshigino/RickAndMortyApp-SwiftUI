//
//  HomePageViewModelTest.swift
//  RickAndMortyAppTests
//
//  Created by Goncalves Higino on 12/03/24.
//

import XCTest
@testable import RickAndMortyApp

class HomePageViewModelTest: XCTestCase {

    var sut:  HomePageViewModel?
    var sutFailure:  HomePageViewModel?
    
    override func setUp() {
        super.setUp()
        sut = HomePageViewModel(useCase: DefaultCharacterUseCase(repository: DefaultCharacterRepository(apiService: CharacterListFakeApiServiceSuccess())))
        sutFailure = HomePageViewModel(useCase: DefaultCharacterUseCase(repository: DefaultCharacterRepository(apiService: CharacterListFakeApiServiceFailure())))
    }
    
    override func tearDown() {
        sut = nil
        sutFailure = nil
        super.tearDown()
    }

}


//MARK: - Success Tests
extension HomePageViewModelTest {
    func testSuccessCase_loadCharacterList() async {
        await sut?.loadCharacterList()
        XCTAssertFalse(sut?.characterList.isEmpty ?? false)
        XCTAssertTrue(sut?.characterList.first?.id == 21)
        
        XCTAssertNil(sut?.viewError)
        if let hasError = sut?.hasError {
            XCTAssertFalse(hasError)
        }
    }
}

//MARK: - Failure Tests
extension HomePageViewModelTest {
    func testFailureCase_loadCharacterList() async {
        guard let sutFailure else { return }
        await sutFailure.loadCharacterList()
        XCTAssertTrue(sutFailure.characterList.isEmpty)
        XCTAssertNotNil(sutFailure.viewError)
        XCTAssertTrue(sutFailure.hasError)
    }
}
