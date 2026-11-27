//
//  LocationViewModel.swift
//  Olho_Vivo
//
//  Created by Dayô Araújo on 27/11/26.
//

import Foundation
import MapKit
import SwiftUI

@Observable
class LocationViewModel {
    private let manager = CLLocationManager()
    var userLocation: CLLocationCoordinate2D?
    var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)

    func requestAuthorization() {
        manager.requestWhenInUseAuthorization()
        userLocation = manager.location?.coordinate
    }

    func centerOnUser() {
        withAnimation {
            cameraPosition = .userLocation(fallback: .automatic)
        }
    }
}
