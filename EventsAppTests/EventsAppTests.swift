//
//  EventsAppTests.swift
//  EventsAppTests
//
//  Created by Hariel Giacomuzzi on 27/07/19.
//  Copyright © 2019 Giacomuzzi. All rights reserved.
//

import XCTest
@testable import EventsApp

class EventsAppTests: XCTestCase {
    var eventsProvider: EventsProviderProtocol!
    var eventsService: EventsServiceProtocol!

    override func setUp() {
        self.eventsProvider = EventsProvider()
        self.eventsService = EventsService(provider: self.eventsProvider)
    }

    override func tearDown() {
        self.eventsProvider = nil
        self.eventsService = nil
    }

    func testFetchEvents() {
        let waitForFetch = expectation(description: "Need to wait until fetch completed")
        waitForFetch.expectedFulfillmentCount = 1

        self.eventsProvider.fetchEvents {data in
            XCTAssertFalse(data.isEmpty)
            waitForFetch.fulfill()
        }

        wait(for: [waitForFetch], timeout: 10.0)
    }

    func testSendCheckinEvent() {
        let waitForCheckin = expectation(description: "Need to wait until checking is done")
        waitForCheckin.expectedFulfillmentCount = 1

        self.eventsProvider.checkinInEvent(eventId: "1",
                                           personName: "John Doe",
                                           personEmail: "a@b.com") {result in
            XCTAssertTrue(result)
            waitForCheckin.fulfill()
        }

        wait(for: [waitForCheckin], timeout: 10.0)
    }

}
