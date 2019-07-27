//
//  DetailViewModel.swift
//  EventsApp
//
//  Created by Hariel Giacomuzzi on 27/07/19.
//  Copyright © 2019 Giacomuzzi. All rights reserved.
//

import Foundation

class DetailViewModel {
    private var event: Event!

    init(event: Event) {
        self.event = event
    }

    func getTitleForEvent() -> String {
        return event.title ?? ""
    }

    func getDetailsForEvent() -> String {
        return event.description ?? ""
    }
}
