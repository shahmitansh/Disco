//
//  Bluetooth.swift
//  DiscoDisco
//
//  Created by Shashwat on 02/06/18.
//  Copyright © 2018 Shashwat. All rights reserved.
//

import Foundation
import CoreBluetooth

protocol ObserverPeripheralsList {
    func update()
}


class CentralBluetooth: NSObject, CBCentralManagerDelegate {
    static let shared = CentralBluetooth()
    
    fileprivate var manager: CBCentralManager!
    
    private var observersPeripheralsList: [ObserverPeripheralsList] = []
    var peripheralsList: [CBPeripheral] = [] {
        didSet {
            for observer in observersPeripheralsList {
                observer.update()
            }
        }
    }
    
    private var waitPeripheralConnectionCallback: [CBPeripheral: (_ peripheral: CBPeripheral, _ error: Error?) -> ()] = [:]
    
    private override init() {
        super.init()
        
        manager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func stopScan() {
        print("Scan for peripheral stoped")
        manager.stopScan()
    }
    
    
    func attachObserverPeripheralsList(_ newObserver: ObserverPeripheralsList) {
        observersPeripheralsList.append(newObserver)
    }
    
    // Receive the update of central manager’s state
    internal func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            // Iniciar o scan. Só podemos fazer isso quando o state for powered on.
            print("Start scan for peripherals")
            manager.scanForPeripherals(withServices: nil, options: nil)
        }
    }
    
    
    internal func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        if peripheralsList.contains(peripheral) == false {
            peripheralsList.append(peripheral)
        }
    }
    
    
    func connect(in peripheral: CBPeripheral, callback: @escaping (_ peripheral: CBPeripheral, _ error: Error?) -> ()) {
        print("Trying connect in peripheral...")
        
        waitPeripheralConnectionCallback[peripheral] = callback
        manager.connect(peripheral, options: nil)
    }
    
    internal func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Success to connect in peripheral")
        
        waitPeripheralConnectionCallback[peripheral]!(peripheral, nil)
        waitPeripheralConnectionCallback.removeValue(forKey: peripheral)
    }
    
    internal func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("Failed to connect in peripheral!")
        
        waitPeripheralConnectionCallback[peripheral]!(peripheral, error)
        waitPeripheralConnectionCallback.removeValue(forKey: peripheral)
    }
}
