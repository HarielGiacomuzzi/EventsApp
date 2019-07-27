//
//  ViewController.swift
//  EventsApp
//
//  Created by Hariel Giacomuzzi on 27/07/19.
//  Copyright © 2019 Giacomuzzi. All rights reserved.
//

import UIKit
import Cards
import ImageLoader

private struct K {
    static let CardTopSpacing = CGFloat(15.0)
    static let CardLeftSpacing = CGFloat(10.0)
    static let CardWidth = UIScreen.main.bounds.width - CardLeftSpacing*2
    static let CardHeight = CGFloat(280.0)
}

class EventsViewController: UIViewController {
    @IBOutlet var scrollVIew: UIScrollView!

    var viewModel: EventsViewModel?
    private var defaultDateFormat: DateFormatter!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel = EventsViewModel(delegate: self)
        self.viewModel?.getEvents()

        self.defaultDateFormat = DateFormatter()
        self.defaultDateFormat.dateFormat = "dd MMM, yyyy"
    }

    private func configureCardView(imageURL: String, frame: CGRect, event: Event) {

        let card = CardHighlight(
            frame: frame
        )

        card.backgroundColor = UIColor.gray
        card.title = event.title ?? ""
        card.itemTitle = "Quando: \(defaultDateFormat.string(from: event.date ?? Date()))"
        card.itemSubtitle = "Preço: \(event.price ?? 0.0)"
        card.textColor = UIColor.black
        card.buttonText = "Fazer check-in"
        card.hasParallax = true

        let cardContentVC = storyboard!.instantiateViewController(
            withIdentifier: "CardContent"
        ) as? DetailViewController

        cardContentVC?.viewModel = DetailViewModel(event: event)
        card.shouldPresent(cardContentVC, from: self, fullscreen: false)

        ImageLoader.request(with: imageURL, onCompletion: { (image, error, _) in
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

        self.scrollVIew.addSubview(card)
    }

}

extension EventsViewController: EventsViewModelDelegate {

    func didFetchEvents() {
        var totalHight = K.CardTopSpacing

        guard let viewModel = self.viewModel else { return }
        for index in 0...viewModel.getNumberOfRows() - 1 {
            if let event = self.viewModel?.getRowData(for: index),
               let imageURL = event.image {

                let frame = CGRect(
                    x: K.CardLeftSpacing,
                    y: totalHight,
                    width: K.CardWidth,
                    height: K.CardHeight
                )

                self.configureCardView(imageURL: imageURL, frame: frame, event: event)

                totalHight += K.CardHeight + K.CardTopSpacing
            }
        }
        self.scrollVIew.contentSize.height = totalHight + K.CardTopSpacing
    }
}
