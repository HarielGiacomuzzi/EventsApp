//
//  Event.swift
//  EventsApp
//
//  Created by Hariel Giacomuzzi on 27/07/19.
//  Copyright © 2019 Giacomuzzi. All rights reserved.
//

import Foundation

class Event: Codable {
    var id: String?
    var title: String?
    var price: Double?
    var latitude: Double?
    var longitude: Double?
    var image: String?
    var description: String?
    var date: Date?
    var people: [Person]?
    var cupons: [Cupom]?

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case latitude
        case longitude
        case image
        case description
        case date
        case people
        case cupons
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decodeIfPresent(String.self, forKey: .id)
        title = try? values.decodeIfPresent(String.self, forKey: .title)
        price = try? values.decodeIfPresent(Double.self, forKey: .price)
        latitude = try? values.decodeIfPresent(Double.self, forKey: .latitude)
        longitude = try? values.decodeIfPresent(Double.self, forKey: .longitude)
        image = try? values.decodeIfPresent(String.self, forKey: .image)
        description = try? values.decodeIfPresent(String.self, forKey: .description)

        let dateInMilis = try? values.decodeIfPresent(String.self, forKey: .date)

        if let milis = dateInMilis,
           let interval = Int64(milis) {
            date = Date(
                timeIntervalSince1970: TimeInterval(
                    integerLiteral: interval
                )
            )
        }

        people = try? values.decodeIfPresent([Person].self, forKey: .people)
        cupons = try? values.decodeIfPresent([Cupom].self, forKey: .cupons)
    }
}
