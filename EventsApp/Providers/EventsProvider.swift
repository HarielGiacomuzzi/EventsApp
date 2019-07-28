//
//  EventsProvider.swift
//  EventsApp
//
//  Created by Hariel Giacomuzzi on 27/07/19.
//  Copyright © 2019 Giacomuzzi. All rights reserved.
//

import Foundation
import Alamofire

protocol EventsProviderProtocol {

    func fetchEvents(completion: @escaping (Data) -> Void)
    func checkinInEvent(eventId: String,
                        personName: String,
                        personEmail: String,
                        completion: @escaping (Bool) -> Void)
}

class EventsProvider: EventsProviderProtocol {

    func checkinInEvent(eventId: String,
                        personName: String,
                        personEmail: String,
                        completion: @escaping (Bool) -> Void) {

        let parameters: [String: Any] = [
            "eventId": eventId,
            "name": personName,
            "email": personEmail
        ]

        Alamofire.request("\(Server.Production)\(Routes.Checkin)",
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default).response { response in
                            if response.response?.statusCode == 200 ||
                                response.response?.statusCode == 201 {
                                completion(true)
                            } else {
                                completion(false)
                            }
        }
    }

    func fetchEvents(completion: @escaping (Data) -> Void) {
        Alamofire.request("\(Server.Production)\(Routes.Events)").responseData { response in
            debugPrint("All Response Info: \(response)")

            switch response.result {
            case .success(let response):
                completion(response)
            case .failure(let error):
                debugPrint("There's a error while fetching data. Details: \(error.localizedDescription)")
                completion(Data())
            }
        }
    }
}
