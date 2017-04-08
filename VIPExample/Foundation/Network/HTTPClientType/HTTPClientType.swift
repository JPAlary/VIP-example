//
//  HTTPClientType.swift
//  MVVMExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import RxSwift

protocol HTTPClientType {
    func request<T: Deserializable>(endpoint: Endpoint) -> Observable<Result<T>>
    func request(endpoint: Endpoint) -> Observable<Response>
}
