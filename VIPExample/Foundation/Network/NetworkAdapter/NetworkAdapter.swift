//
//  NetworkAdapter.swift
//  MVVMExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import RxSwift

protocol NetworkAdapter {
    func rx_send(request: URLRequest) -> Observable<Response>
}
