//
//  RickAndMortyTests.swift
//  RickAndMortyTests
//
//  Created by Balla Tamás on 2022. 10. 14..
//

import XCTest
@testable import RickAndMorty


class RickAndMortyTests: XCTestCase {
    
    var sut: CharacterModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    let api = RickAndMortyApi.instance
    func testApiForSingleCharacter() {
        
        let expectation = XCTestExpectation(description: "Request one character by id")
    
        api.getCharacter(id: 1) { character in
            print("character name: \(character.name)")
            expectation.fulfill()
        }
        
        
        wait(for: [expectation], timeout: 10.0)
        
    }

    func testApiPerformance() {
        measure {
            api.getCharacters { _ in
                print("Got characters")
            }
        }
    }

}
