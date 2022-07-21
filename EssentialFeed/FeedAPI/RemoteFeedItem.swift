//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Srilatha Karancheti on 2022-07-20.
//

import Foundation

internal struct RemoteFeedItem: Codable {
    internal let id: UUID
    internal let description: String?
    internal let location: String?
    internal let image: URL
}
