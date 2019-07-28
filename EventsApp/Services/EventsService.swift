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
    func checkinPerson(eventId: String,
                       personName: String,
                       personEmail: String,
                       completion: @escaping (Bool) -> Void)
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
                let sortedEvents = decodedEvents.sorted { lhs, rhs in
                    guard let firstDate = lhs.date,
                        let secondDate = rhs.date else { return false }
                    return firstDate > secondDate
                }
                completion(sortedEvents)
            }
            completion([])
        }
    }

    func checkinPerson(eventId: String,
                       personName: String,
                       personEmail: String,
                       completion: @escaping (Bool) -> Void) {

        self.provider?.checkinInEvent(eventId: eventId,
                                      personName: personName,
                                      personEmail: personEmail,
                                      completion: completion)
    }
}
