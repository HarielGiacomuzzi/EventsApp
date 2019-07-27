//
//  EventsViewModel.swift
//  EventsApp
//
//  Created by Hariel Giacomuzzi on 27/07/19.
//  Copyright © 2019 Giacomuzzi. All rights reserved.
//

import Foundation

protocol EventsViewModelDelegate: class {
    func didFetchEvents()
}

class EventsViewModel {
    weak var delegate: EventsViewModelDelegate?
    private var service: EventsServiceProtocol?
    private var events: [Event] = []

    init(delegate: EventsViewModelDelegate, service: EventsServiceProtocol = EventsService()) {
        self.service = service
        self.delegate = delegate
    }

    func getEvents() {
        guard let service = self.service,
            let delegate = self.delegate else { return }
        service.getEvents { events in
            if events.count > 0 {
                self.events = events
                delegate.didFetchEvents()
            }
        }
    }

    func getNumberOfRows() -> Int {
        return self.events.count - 1
    }

    func getRowData(for index: Int) -> Event {
        return self.events[index]
    }
}
