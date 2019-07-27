//
//  EventsService.swift
//  EventsApp
//
//  Created by Hariel Giacomuzzi on 27/07/19.
//  Copyright © 2019 Giacomuzzi. All rights reserved.
//

import Foundation

protocol EventsServiceProtocol {

    func getEvents(completion: @escaping ([Event]) -> Void)
    func checkinPerson(event: Event, person: Person, completion: @escaping (Bool) -> Void)
}

class EventsService: EventsServiceProtocol {
    private var allEvents: [Event]?
    private var provider: EventsProviderProtocol?

    init(provider: EventsProviderProtocol = EventsProvider()) {
        self.provider = provider
    }

    func getEvents(completion: @escaping ([Event]) -> Void) {
        self.provider?.fetchEvents { data in
            if let decodedEvents = try? JSONDecoder().decode(
                    [Event].self, from: data
                ) {
                completion(decodedEvents)
            }
            completion([])
        }
    }

    func checkinPerson(event: Event, person: Person, completion: @escaping (Bool) -> Void) {
        self.provider?.checkinInEvent(
                event: event,
                person: person,
                completion: completion
        )
    }
}
