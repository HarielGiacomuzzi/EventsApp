//
//  Cupom.swift
//  EventsApp
//
//  Created by Hariel Giacomuzzi on 27/07/19.
//  Copyright © 2019 Giacomuzzi. All rights reserved.
//

import Foundation

class Cupom: Codable {
    var id: String?
    var eventId: String?
    var discount: Int?

    private enum CodingKeys: String, CodingKey {
        case id
        case eventId
        case discount
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decodeIfPresent(String.self, forKey: .id)
        eventId = try? values.decodeIfPresent(String.self, forKey: .eventId)
        discount = try? values.decodeIfPresent(Int.self, forKey: .discount)
    }
}
