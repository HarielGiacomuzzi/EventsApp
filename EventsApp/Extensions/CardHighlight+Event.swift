//
//  CardHighlight+Event.swift
//  EventsApp
//
//  Created by Hariel Giacomuzzi on 28/07/19.
//  Copyright © 2019 Giacomuzzi. All rights reserved.
//

import Foundation
import Cards

func associatedObject<ValueType: AnyObject>(
    base: AnyObject,
    key: UnsafePointer<UInt8>,
    initialiser: () -> ValueType)
    -> ValueType {
        if let associated = objc_getAssociatedObject(base, key)
            as? ValueType { return associated }
        let associated = initialiser()
        objc_setAssociatedObject(base, key, associated,
                                 .OBJC_ASSOCIATION_RETAIN)
        return associated
}
func associateObject<ValueType: AnyObject>(
    base: AnyObject,
    key: UnsafePointer<UInt8>,
    value: ValueType) {
    objc_setAssociatedObject(base, key, value,
                             .OBJC_ASSOCIATION_RETAIN)
}

private var eventKey: UInt8 = 0
extension CardHighlight {
    var eventModel: Event {
        get {
            return associatedObject(base: self, key: &eventKey) {
                return self.eventModel

            }
        }
        set { associateObject(base: self, key: &eventKey, value: newValue) }
    }
}
