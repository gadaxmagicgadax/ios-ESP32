# ios-ESP32
Esempio di definizione di un beacon in protocollo BLE su ESP32 e una app su iPhone (sviluppata con xcode 11) che dovrebbe fare la discover ed individuare la distanza nel range. di seguito il codice nel file ViewController.swift che non funziona con ESP32. Con il simulatore beacon su iPad invece funziona.

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
