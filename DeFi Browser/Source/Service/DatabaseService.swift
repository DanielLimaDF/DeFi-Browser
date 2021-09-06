//
//  DatabaseService.swift
//  DeFi Browser
//
//  Created by Daniel Lima on 21/08/21.
//

import Foundation
import RealmSwift

class DatabaseService {
    
    let realm: Realm
    
    init(config: Realm.Configuration) {
        do {
            realm = try Realm(configuration: config)
        } catch {
            fatalError("Unable to start database")
        }
    }
    
    //MARK: - Bookmark
    
    func getBookmarks() -> [DefiItem] {
        var bookmarks: [DefiItem] = Array()
        
        let result = realm.objects(DefiItemDao.self)
        bookmarks = result.compactMap({ $0.item() })
        
        return bookmarks
    }
    
    func isBookmarked(item: DefiItem) -> Bool {
        let result = realm.objects(DefiItemDao.self).filter("url = %@", item.url)
        return result.count > 0
    }
    
    func addBookmark(item: DefiItem) {
        
        let newBookmark = DefiItemDao(item: item)
        
        do {
            try realm.write {
                realm.add(newBookmark)
            }
        } catch {
            debugPrint(error)
        }
    }
    
    func removeBookmark(item: DefiItem) {
        
        let result = realm.objects(DefiItemDao.self).filter("url = %@", item.url)
        
        do {
            try realm.write {
                realm.delete(result)
            }
        } catch {
            debugPrint(error)
        }
    }
    
    func toggleBookmark(item: DefiItem) {
        if isBookmarked(item: item) {
            removeBookmark(item: item)
        } else {
            addBookmark(item: item)
        }
    }

    //MARK: - History
    
    func getHistory() -> [HistoryItemDao] {
        var historyItems: [HistoryItemDao] = Array()
        
        let result = realm.objects(HistoryItemDao.self)
        historyItems = result.compactMap({ $0 })
        historyItems.sort(by: { $0.date > $1.date })
        
        return historyItems
    }
    
    func addHistory(item: DefiItem) {
        
        let newHstory = HistoryItemDao(item: item)
        
        do {
            try realm.write {
                realm.add(newHstory)
            }
        } catch {
            debugPrint(error)
        }
    }
    
    func removeHistory(item: HistoryItemDao) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            debugPrint(error)
        }
    }
    
    func clearHistory() {
        do {
            try realm.write {
                realm.delete(realm.objects(HistoryItemDao.self))
            }
        } catch {
            debugPrint(error)
        }
    }
    
}
