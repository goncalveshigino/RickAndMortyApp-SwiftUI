//
//  SearchPageViewModelTest.swift
//  RickAndMortyAppTests
//
//  Created by Goncalves Higino on 13/03/24.
//

import XCTest
@testable import RickAndMortyApp

class SearchPageViewModelTest: XCTestCase {
    
    private var sut: SearchPageViewModel?
    private var sutFailure: SearchPageViewModel?
    
    override func setUp() {
        super.setUp()
        sut = SearchPageViewModel(useCase: DefaultCharacterUseCase(repository: DefaultCharacterRepository(apiService: CharacterListFakeApiServiceSuccess())))
        sutFailure = SearchPageViewModel(useCase: DefaultCharacterUseCase(repository: DefaultCharacterRepository(apiService: CharacterListFakeApiServiceFailure())))
    }
    
    override func tearDown() {
        sut = nil
        sutFailure = nil
        super.tearDown()
    }
    
}

//MARK: - Success Tests
extension SearchPageViewModelTest {
    func testSuccessCase_searchCharacterByName() async {
       await sut?.searchCharacter(by: "Rick", isFirstLoad: true)
        XCTAssertTrue(sut?.characterList.first?.id == 21)
    }
    
    func testSuccessCase_searchCharacterEmptyName() async {
       await sut?.searchCharacter(by: "", isFirstLoad: true)
        XCTAssertTrue(sut?.characterList.isEmpty ?? false)
    }
}

extension SearchPageViewModelTest {
    func testFailureCase_loadCharacterList() async {
        //GIVEN
        guard let sutFailure else { return }
        //WHEN
        await sutFailure.searchCharacter(by: "Rick", isFirstLoad: true)
        //THEN
        XCTAssertTrue(sutFailure.characterList.isEmpty)
    }
}
