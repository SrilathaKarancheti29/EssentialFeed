//
//  CacheFeedUseCaseTests.swift
//  EssentialFeedTests
//
//  Created by Srilatha Karancheti on 2022-07-17.
//

import XCTest

class FeedStore {
    var deletedCachedFeedCallCount = 0
}

class LocalFeedLoader {
    var feedStore: FeedStore
    
    init(store: FeedStore) {
        self.feedStore = store
    }
}

class CacheFeedUseCaseTests: XCTestCase {
    
    func test_init_doesNotDeleteCacheUponCreation() {
        let store = FeedStore()
        _ = LocalFeedLoader(store: store)
        XCTAssertEqual(store.deletedCachedFeedCallCount, 0)
    }

}
