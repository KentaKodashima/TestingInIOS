//
//  MockSession.swift
//  DogYears
//
//  Created by Kenta Kodashima on 2019-01-01.
//  Copyright © 2019 Razeware. All rights reserved.
//

import Foundation

class MockSession: URLSessionProtocol {
  func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
    completionHandler(Data(), nil, nil)
    
    return MockDataTask()
  }
}
