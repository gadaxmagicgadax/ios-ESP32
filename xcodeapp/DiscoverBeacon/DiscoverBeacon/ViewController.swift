//
//  ViewController.swift
//  DiscoverBeacon
//
//  Created by giovanni gadaleta on 31/05/2020.
//  Copyright © 2020 nextrace. All rights reserved.
//

import CoreBluetooth
import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var AuthLabel: UILabel!
    
    @IBOutlet weak var BeaconLabel: UILabel!
    
    @IBOutlet weak var ProximityLabel: UILabel!
    
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        
        view.backgroundColor = .gray
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            AuthLabel.text = "yes is authorized !!"
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
            
        }
    }
    
    func startScanning() {
        // this doesn't work with ESP32
        // let uuid = UUID(uuidString: "74278BDA-B644-4520-8F0C-720EAF059935")!
       
        // let beaconRegion = CLBeaconRegion.init(uuid: uuid, major: 4, minor: 0, identifier: "ESP32Beacon")
 
        // locationManager?.startMonitoring(for: beaconRegion)

        // locationManager?.startRangingBeacons(in: beaconRegion)
        
        // this works with Locate on iPad
        let uuid = UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!
        let beaconRegion = CLBeaconRegion.init(uuid: uuid, major: 1, minor: 16, identifier: "Estimote B9407F30")
        
        locationManager?.startMonitoring(for: beaconRegion)
        
        locationManager?.startRangingBeacons(in: beaconRegion)
    }
    
    func update(distance: CLProximity) {
        UIView.animate(withDuration: 1) {
            switch distance {
            
            case .far:
                self.view.backgroundColor = .blue
                self.ProximityLabel.text = "FAR !"
            case .near:
                self.view.backgroundColor = .orange
                self.ProximityLabel.text = "NEAR !"
            case .immediate:
                self.view.backgroundColor = .red
                self.ProximityLabel.text = "RIGHT HERE !!"
            default:
                self.view.backgroundColor = .gray
                self.ProximityLabel.text = "UNKNOWN default"
            }
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        BeaconLabel.text = "n. beacons \(beacons.count)"
        if let beacon = beacons.first {
            update(distance: beacon.proximity)
        }
        else {
            update(distance: .unknown)
        }

    }
    
    func locationManager(_ manager: CLLocationManager, rangingBeaconsDidFailFor region: CLBeaconRegion, withError error: Error) {
        print(error)
    }
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("start monitoring for region !!")
    }
    
    
}

