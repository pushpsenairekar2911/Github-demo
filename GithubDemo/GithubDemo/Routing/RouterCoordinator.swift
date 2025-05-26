//
//  RouterCoordinator.swift
//  Github-Demo
//
//  Created by Pushpsen Airekar on 25/05/25.
//

import SwiftUI

class RouterCoordinator {
    private var handlers: [RouteHandler]

    init(handlers: [RouteHandler]) {
        self.handlers = handlers
    }

    func resolveView(for route: Route) -> AnyView {
        for handler in handlers {
            if let view = handler.view(for: route) {
                return view
            }
        }
        return AnyView(Text("Unknown route"))
    }
}
