//
//  ViewController.swift
//  DiscoDisco
//
//  Created by Shashwat on 02/06/18.
//  Copyright © 2018 Shashwat. All rights reserved.
//




import UIKit
import CoreBluetooth




class ViewController:
    UIViewController,
    CBCentralManagerDelegate,
    CBPeripheralDelegate {

    var manager: CBCentralManager!
    var device: CBPeripheral?
    var characteristics: [CBCharacteristic]?
    var serviceUUID = "1234"
    var char1 = "FFE1"
    let deviceName = "HMSoft"
    var connected = CBPeripheralState.connected
    var disconnected = CBPeripheralState.disconnected

//    var manager:CBCentralManager!
//    var peripheral:CBPeripheral!
//
//    let BEAN_NAME = "Robu"
//    let BEAN_SCRATCH_UUID =
//        CBUUID(string: "a495ff21-c5b1-4b44-b512-1370f02d74de")
//    let BEAN_SERVICE_UUID =
//        CBUUID(string: "a495ff20-c5b1-4b44-b512-1370f02d74de")
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        manager = CBCentralManager(delegate: self, queue: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
//    func centralManagerDidUpdateState(_ central: CBCentralManager) {
//        if (central.state == .poweredOn) {
//            print("Bluetooth ---666y2134522ayyy")
//            central.scanForPeripherals(withServices: nil, options: nil)
//        } else {
//            print("Bluetooth not available.")
//        }
//        print("Bluetooth ----y22ayyy")
//    }
//
//
//    private func centralManager(
//
//        central: CBCentralManager,
//        didDiscoverPeripheral peripheral: CBPeripheral,
//        advertisementData: [String : AnyObject],
//        RSSI: NSNumber) {
//        print("Bluetooth y22ayyy")
//        let device = (advertisementData as NSDictionary)
//            .object(forKey: CBAdvertisementDataLocalNameKey)
//            as? NSString
//
//        if device?.contains(BEAN_NAME) == true {
//            self.manager.stopScan()
//
//            self.peripheral = peripheral
//            self.peripheral.delegate = self
//            print("Bluetooth 11133yayyy")
//            manager.connect(peripheral, options: nil)
//        }
//    }
//
//
//    private func centralManager(
//
//        central: CBCentralManager,
//        didConnectPeripheral peripheral: CBPeripheral) {
//        print("Bluetooth y22ayyy")
//        peripheral.discoverServices(nil)
//        print("Bluetooth 33yayyy")
//    }
//
//
//    private func peripheral(
//        peripheral: CBPeripheral,
//        didDiscoverCharacteristicsForService service: CBService,
//        error: Error?) {
//        print("Bluetooth y22ayyy")
//        for characteristic in service.characteristics! {
//            let thisCharacteristic = characteristic as CBCharacteristic
//            print("Bluetooth y44ayyy")
//            if thisCharacteristic.uuid == BEAN_SCRATCH_UUID {
//                self.peripheral.setNotifyValue(
//                    true,
//                    for: thisCharacteristic
//                )
//            }
//        }
//    }
//
//
//    private func peripheral(
//        peripheral: CBPeripheral,
//        didUpdateValueForCharacteristic characteristic: CBCharacteristic,
//        error: NSError?) {
//        print("Bluetooth y22ayyy")
//        var _:UInt32 = 0;
//
//        if characteristic.uuid == BEAN_SCRATCH_UUID {
////            characteristic.value!.getBytes(&count, length: sizeof(UInt32))
////            labelCount.text =
////                NSString(format: "%llu", count) as String
//            print("Bluetooth yayyy")
//        }
//    }

    @IBOutlet weak var Screen: UIView!
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn: break
        manager.scanForPeripherals(withServices: nil, options: nil)
        case .unknown: break
            
        case .resetting: break
            
        case .unsupported: break
            
        case .unauthorized: break
            
        case .poweredOff:
            
            break
            
        }
    }

    
    
    @IBAction func Connect(_ sender: Any) {
        manager = CBCentralManager(delegate: self, queue: nil)
//        manager.scanForPeripherals(withServices: nil, options: nil)
        
        func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
            
            if let peripheralName = advertisementData[CBAdvertisementDataLocalNameKey] as? String {
                
                if peripheralName == self.deviceName {
                    
                    // save a reference to the sensor tag
                    self.device = peripheral
                    self.device!.delegate = self
                    
                    // Request a connection to the peripheral
                    
                    self.manager.connect(self.device!, options: nil)
                    
                    print("Check")
                }
            }
        }
        
        func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
            
            peripheral.discoverServices(nil)
        }
        
        
        func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
            
            if error != nil {
                
                return
            }
            
            
            if let services = peripheral.services {
                for service in services {
                    
                    if (service.uuid == CBUUID(string: serviceUUID)) {
                        peripheral.discoverCharacteristics(nil, for: service)
                    }
                }
            }
            
        }
        
        
        func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
            
            device = peripheral
            characteristics = service.characteristics
            
        }
        
        func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
            if error != nil {
                
                return
            }
        }
    }
//        manager = CBCentralManager(delegate: self, queue: nil)
//        manager.scanForPeripherals(withServices: nil, options: nil)
//    }

    
    
    
//    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
//
//        if let peripheralName = advertisementData[CBAdvertisementDataLocalNameKey] as? String {
//
//            if peripheralName == self.deviceName {
//
//                // save a reference to the sensor tag
//                self.device = peripheral
//                self.device!.delegate = self
//
//                // Request a connection to the peripheral
//
//                self.manager.connect(self.device!, options: nil)
//
//                print("Check")
//            }
//        }
//    }
//
//
//    func centralManagerDidUpdateState(_ central: CBCentralManager) {
//        switch (central.state) {
//        case .unsupported:
//            print("BLE is unsupported")
//        case .unauthorized:
//            print("BLE is unauthorized")
//        case .unknown:
//            print("BLE is unknown")
//        case .resetting:
//            print("BLE is reseting")
//        case .poweredOff:
//            print("BLE is powered off")
//        case .poweredOn:
//            print("BLE is powered on")
//            //must be called
//        }
//    }




    @IBAction func Switch(_ sender: UISwitch) {
        if (sender.isOn == true)
        {
//            Screen.backgroundColor = UIColor.red
            UIView.animate(withDuration: 0.75, delay: -0.5, options:[UIViewAnimationOptions.curveLinear], animations: {
                self.Screen.backgroundColor = UIColor.red
                self.Screen.backgroundColor = UIColor.blue
                self.Screen.backgroundColor = UIColor.yellow
                self.Screen.backgroundColor = UIColor.green
                self.Screen.backgroundColor = UIColor.black
                self.Screen.backgroundColor = UIColor.white
                self.Screen.backgroundColor = UIColor.orange
                self.Screen.backgroundColor = UIColor.cyan
            }, completion: nil)

        }
        else
        {
            Screen.layer .removeAllAnimations()

        }
        
     
    }
}


