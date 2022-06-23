//
//  HTTPClient.swift
//  Networking
//
//  Created by Srilatha Karancheti on 2022-06-07.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
