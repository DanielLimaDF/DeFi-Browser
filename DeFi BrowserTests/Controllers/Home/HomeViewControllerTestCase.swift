//
//  HomeViewControllerTestCase.swift
//  DeFi BrowserTests
//
//  Created by Daniel Lima on 04/09/21.
//

import Foundation
import XCTest

@testable import DeFi_Browser

class HomeViewControllerTestCase: XCTestCase {
    
    var sut: HomeViewController!
    var databaseService: FakeDatabaseService!
    var fakeCoordinator: FakeCoordinator<HomeAction>!
    
    override func setUp() {
        super.setUp()
        databaseService = FakeDatabaseService()
        databaseService.addBookmark(item: DefiItem(title: "FakeBookMark", description: "Bookmark Description", iconURL: "https://fake.icon/icon.png", url: "https://fake.home.url"))
        sut = HomeViewController(service: FakeDefiService(), databaseService: databaseService)
        fakeCoordinator = FakeCoordinator(controller: sut)
    }
    
    override func tearDown() {
        fakeCoordinator = nil
        databaseService = nil
        sut = nil
        super.tearDown()
    }
    
    func testDefaultValues() {
        XCTAssertEqual(sut.dApps.count, 8)
        XCTAssertEqual(sut.bookmarks.count, 3)
        XCTAssertTrue(sut.view is HomeView)
    }
    
    func testNavigationSetup() throws {
        let navigationController = try XCTUnwrap(sut.navigationController)
        XCTAssertTrue(navigationController.isNavigationBarHidden)
    }
    
    func testDeleteBookmark() throws {
        let lastBookmark = try XCTUnwrap(sut.bookmarks.last)
        sut.deleteBookmark(item: lastBookmark)
        XCTAssertEqual(sut.bookmarks.count, 2)
    }
    
    func testDeFiSelectionAction() throws {
        let deFiModel = try XCTUnwrap(((sut.view as? HomeView)?.viewModel?.sections[0] as? DAppSection)?.viewModels[0].models[0])
        deFiModel.didAction?()
        
        XCTAssertEqual(
            fakeCoordinator.lastAction,
            HomeAction.goToItem(
                defiItem: DefiItem(
                    title: "PancakeSwap",
                    description: "Cheaper and faster than Uniswap? Discover PancakeSwap, the leading DEX on Binance Smart Chain (BSC) with the best farms in DeFi and a lottery for CAKE.",
                    iconURL: "https://pancakeswap.finance/logo.png",
                    url: "https://pancakeswap.finance"
                )
            )
        )
    }
    
    func testDidSelectURL() throws {
        let url = try XCTUnwrap(URL(string: "https://fakeurl.com"))
        sut.didSelectURL(url: url)
        
        XCTAssertEqual(fakeCoordinator.lastAction, HomeAction.goToURL(url: url))
    }
    
    func testDidSelectSearch() throws {
        sut.didSelectSearch(text: "searchText")
        
        XCTAssertEqual(fakeCoordinator.lastAction, HomeAction.searchText(text: "searchText"))
    }
    
}
