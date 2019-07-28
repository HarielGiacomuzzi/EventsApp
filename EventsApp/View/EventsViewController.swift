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
    static let CardBorderSpacing = CGFloat(15.0)
    static let CardWidth = UIScreen.main.bounds.width - CardBorderSpacing*2
    static let CardHeight = CGFloat(280.0)
}

class EventsViewController: UIViewController {
    @IBOutlet var scrollVIew: UIScrollView!

    var viewModel: EventsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel = EventsViewModel(delegate: self)
        self.viewModel?.getEvents()
    }

    private func configureCardView(frame: CGRect,
                                   event: Event,
                                   index: Int) {

        let card = CardHighlight(
            frame: frame
        )

        viewModel?.configureEventCard(card: card, index: index)
        card.delegate = self

        let cardContentVC = storyboard?.instantiateViewController(
            withIdentifier: "CardContent"
            ) as? DetailViewController

        cardContentVC?.viewModel = DetailViewModel(event: event)
        card.shouldPresent(cardContentVC, from: self, fullscreen: false)

        self.scrollVIew.addSubview(card)
    }

}

extension EventsViewController: EventsViewModelDelegate {

    func didFetchEvents() {
        var totalHeight = K.CardTopSpacing

        guard let viewModel = self.viewModel else { return }
        for index in 0...viewModel.getNumberOfRows() {
            if let event = self.viewModel?.getRowData(for: index) {

                let frame = CGRect(
                    x: K.CardBorderSpacing,
                    y: totalHeight,
                    width: K.CardWidth,
                    height: K.CardHeight
                )

                self.configureCardView(frame: frame,
                                       event: event,
                                       index: index)

                totalHeight += K.CardHeight + K.CardTopSpacing
            }
        }
        self.scrollVIew.contentSize.height = totalHeight + K.CardTopSpacing
    }
}

extension EventsViewController: CardDelegate {

    func cardHighlightDidTapButton(card: CardHighlight, button: UIButton) {
        switch card.buttonText {
        case CardAction.fazerCheckin.rawValue:
            viewModel?.doCheckin(event: card.eventModel)
        default:
            guard let viewModel = self.viewModel else { return }
            let activityView = viewModel.getShareContextMenu(event: card.eventModel)
            activityView.popoverPresentationController?.sourceView = self.view
            self.present(activityView, animated: true, completion: nil)
        }
    }

    func cardWillShowDetailView(card: Card) {
        if let card = card as? CardHighlight {
            card.buttonText = CardAction.fazerCheckin.rawValue
        }
    }

    func cardWillCloseDetailView(card: Card) {
        if let card = card as? CardHighlight {
            card.buttonText = CardAction.compartilhar.rawValue
        }
    }

}
