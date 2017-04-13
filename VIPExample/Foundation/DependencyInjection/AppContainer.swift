//
//  AppContainer.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 06/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import Swinject

protocol AppContainer {
    func getChild() -> Container
    func resolve<Service>(serviceType: Service.Type) -> Service?
    func resolve<Service>(serviceType: Service.Type, name: String) -> Service?
}
