//
//  DetailViewController.swift
//  EventsApp
//
//  Created by Hariel Giacomuzzi on 27/07/19.
//  Copyright © 2019 Giacomuzzi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailsText: UITextView!

    var viewModel: DetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let viewModel = self.viewModel else { return }
        self.titleLabel.text = viewModel.getTitleForEvent()
        self.detailsText.text = viewModel.getDetailsForEvent()
    }

}
