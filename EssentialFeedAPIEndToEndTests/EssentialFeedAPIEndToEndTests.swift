//
//  EssentialFeedAPIEndToEndTests.swift
//  EssentialFeedAPIEndToEndTests
//
//  Created by Srilatha Karancheti on 2022-06-23.
//

import XCTest
import EssentialFeed

class EssentialFeedAPIEndToEndTests: XCTestCase {
    
    func test_endToEndTestServerGETFeedResult_matchesFixedTestAccountData() {
        let testServerURL = URL(string: "https://static1.squarespace.com/static/5891c5b8d1758ec68ef5dbc2/t/5c52cdd0b8a045df091d2fff/1548930512083/feed-case-study-test-api-feed.json")!
        let client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
        let loader = RemoteFeedLoader(url: testServerURL, client: client)

        let exp = expectation(description: "Wait for load completion")
        var receivedResult: LoadFeedResult?

        loader.load{ result in
            receivedResult = result
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5.0)

        switch receivedResult {
        case let .success(items)?:
            XCTAssertEqual(items.count, 8)
        case let .failure(error)?:
            XCTFail("Expected success but received \(error)")
        default:
            XCTFail("Expected successful feed result but no result instead")
        }
    }

}
