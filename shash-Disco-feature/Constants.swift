//
//  Constants.swift
//  DiscoDisco
//
//  Created by Shashwat on 02/06/18.
//  Copyright © 2018 Shashwat. All rights reserved.
//

import Foundation
import CoreBluetooth


extension CBUUID {
    static let serviceChat = CBUUID(string: "1000")
    static let characteristicChatMessage = CBUUID(string: "1001")
}
