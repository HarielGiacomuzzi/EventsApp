//
//  Person.swift
//  EventsApp
//
//  Created by Hariel Giacomuzzi on 27/07/19.
//  Copyright © 2019 Giacomuzzi. All rights reserved.
//

import Foundation

class Person: Codable {
    var id: String?
    var eventId: String?
    var name: String?
    var picture: String?
    var email: String? = ""

    private enum CodingKeys: String, CodingKey {
        case id
        case eventId
        case name
        case picture
        case email
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decodeIfPresent(String.self, forKey: .id)
        eventId = try? values.decodeIfPresent(String.self, forKey: .eventId)
        name = try? values.decodeIfPresent(String.self, forKey: .name)
        picture = try? values.decodeIfPresent(String.self, forKey: .picture)
    }

}
