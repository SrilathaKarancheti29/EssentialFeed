//
//  CacheFeedUseCaseTests.swift
//  EssentialFeedTests
//
//  Created by Srilatha Karancheti on 2022-07-17.
//

import XCTest
import EssentialFeed

class FeedStore {
    var deletedCachedFeedCallCount = 0
    var insertCallCount = 0
    
    func deleteCachedFeed() {
        deletedCachedFeedCallCount += 1
    }
    
    func completeDeletion(with error: NSError, at index: Int = 0) {
        
    }
}

class LocalFeedLoader {
    var store: FeedStore
    
    init(store: FeedStore) {
        self.store = store
    }

    func save(_ items: [FeedItem]) {
        store.deleteCachedFeed()
    }
}

class CacheFeedUseCaseTests: XCTestCase {
    
    func test_init_doesNotDeleteCacheUponCreation() {
        let (_, store) = makeSUT()

        XCTAssertEqual(store.deletedCachedFeedCallCount, 0)
    }
    
    func test_save_requestsCacheDeletion() {
        let items = [uniqueItem(), uniqueItem()]
        let (sut, store) = makeSUT()

        sut.save(items)

        XCTAssertEqual(store.deletedCachedFeedCallCount, 1)
    }
    
    func test_save_doesNotRequestCacheInsertionOnDeletionError() {
        
        let items = [uniqueItem(), uniqueItem()]
        let (sut, store) = makeSUT()
        let deletionError = anyNSError

        sut.save(items)
        store.completeDeletion(with: deletionError)
        XCTAssertEqual(store.insertCallCount, 0)
    }

    // MARK: - Helpers
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: LocalFeedLoader, store: FeedStore) {
        let store = FeedStore()
        let sut = LocalFeedLoader(store: store)
        trackMemoryLeaks(store, file: file, line: line)
        trackMemoryLeaks(sut, file: file, line: line)
        return (sut, store)
    }
    
    private func uniqueItem() -> FeedItem {
        return FeedItem(id: UUID(), description: "any", location: "any", imageURL: anyURL)
    }
    
    private var anyURL: URL {
        URL(string: "http://any-url.com")!
    }
    
    private var anyNSError: NSError {
        return NSError(domain: "any error", code: 0)
    }

}
