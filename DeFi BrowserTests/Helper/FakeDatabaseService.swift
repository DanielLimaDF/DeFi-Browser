//
//  FakeDatabaseService.swift
//  DeFi BrowserTests
//
//  Created by Daniel Lima on 01/09/21.
//

import Foundation
import RealmSwift

@testable import DeFi_Browser

class FakeDatabaseService: DatabaseService {
    
    var wasAddHistoryCalled = false
    var wasAddBookmarkCalled = false
    
    required init() {
        var configuration = Realm.Configuration(schemaVersion: 1)
        configuration.inMemoryIdentifier = "InMemoryRealm"
        super.init(config: configuration)
    }
    
    override func addBookmark(item: DefiItem) {
        super.addBookmark(item: item)
        wasAddBookmarkCalled = true
    }
    
    override func addHistory(item: DefiItem) {
        super.addHistory(item: item)
        wasAddHistoryCalled = true
    }
    
    override func isBookmarked(item: DefiItem) -> Bool {
        return wasAddBookmarkCalled
    }
    
}
