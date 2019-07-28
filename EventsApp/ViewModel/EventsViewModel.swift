//
//  EventsViewModel.swift
//  EventsApp
//
//  Created by Hariel Giacomuzzi on 27/07/19.
//  Copyright © 2019 Giacomuzzi. All rights reserved.
//

import Foundation
import Cards
import ImageLoader

protocol EventsViewModelDelegate: class {
    func didFetchEvents()
}

public enum CardAction: String {
    case fazerCheckin = "Fazer check-in"
    case compartilhar = "Compartilhar"
}

class EventsViewModel {
    weak var delegate: EventsViewModelDelegate?
    private var service: EventsServiceProtocol?
    private var events: [Event] = []
    private var defaultDateFormat: DateFormatter!

    init(delegate: EventsViewModelDelegate, service: EventsServiceProtocol = EventsService()) {
        self.service = service
        self.delegate = delegate

        self.defaultDateFormat = DateFormatter()
        self.defaultDateFormat.dateFormat = "dd MMM"
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

    func configureEventCard(card: CardHighlight, index: Int) {
        card.backgroundColor = UIColor.gray
        card.title = events[index].title ?? ""
        card.itemTitle = "\(NSLocalizedString("when", comment: "")): \(defaultDateFormat.string(from: events[index].date ?? Date()))"
        card.itemSubtitle = "\(NSLocalizedString("price", comment: "")): \(events[index].price ?? 0.0)"
        card.textColor = UIColor.black
        card.buttonText = CardAction.compartilhar.rawValue
        card.backgroundImage = #imageLiteral(resourceName: "placeHolder")
        card.hasParallax = true
        card.eventModel = events[index]

        ImageLoader.request(with: events[index].image ?? "", onCompletion: { (image, error, _) in
            guard let img = image else {
                debugPrint("""
                    There's an error retrieving the image.
                    Details: \(error!.localizedDescription)
                    """)

                return }
            DispatchQueue.main.async {
                card.backgroundImage = img
                card.title = ""
            }
        })
    }

    func doCheckin(event: Event) {
        // This would usually be picked from user session, since we don't have
        // login system on this app, I just used a mock user data
        self.service?.checkinPerson(
            eventId: event.id ?? "",
            personName: "John Doe",
            personEmail: "john@doe.com"
        ) { (result) in
            if !result {
                debugPrint("There's an error while doing checking")
            } else {
                // Also there's no action before checkin for now
                // therefore I just use a debug print
                debugPrint("Successfully checked-in")
            }
        }
    }

    func getShareContextMenu(event: Event) -> UIActivityViewController {
        // text to share
        let text = """
            \(event.title ?? "") - \(defaultDateFormat.string(from: event.date ?? Date()))
            \n\(event.description ?? "")
        """

        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)

        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop ]

        return activityViewController
    }

    func getNumberOfRows() -> Int {
        return self.events.count - 1
    }

    func getRowData(for index: Int) -> Event {
        return self.events[index]
    }
}
