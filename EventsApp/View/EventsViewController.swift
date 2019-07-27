//
//  ViewController.swift
//  EventsApp
//
//  Created by Hariel Giacomuzzi on 27/07/19.
//  Copyright © 2019 Giacomuzzi. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController {

    var viewModel: EventsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel = EventsViewModel(delegate: self)
        self.viewModel?.getEvents()
    }

}

extension EventsViewController: EventsViewModelDelegate {

    func didFetchEvents() {
        debugPrint("Did fetched events")
    }
}
