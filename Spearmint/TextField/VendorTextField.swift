//
//  VendorTextField.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/29/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit
import MapKit

class VendorTextField: UITextField {
    let locationManager = CLLocationManager()

    var view: SuggestionsView
    var mapRegion: MKCoordinateRegion?
    
    override init(frame: CGRect) {
        view = SuggestionsView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 45))
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        view = SuggestionsView(frame: CGRect(x: 0, y: 0, width: 0, height: 45))
        super.init(coder: aDecoder)
        setUp()
    }
    
    func setUp() {
        self.borderStyle = UITextField.BorderStyle.none
        self.placeholder = "vendor"
        self.textAlignment = .center
        self.keyboardType = UIKeyboardType.default
        self.autocorrectionType = .no
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
//        self.clearButtonMode = UITextField.ViewMode.whileEditing

        self.delegate = self
        
        view.frame.size.width = self.frame.width
        view.textField = self
        self.inputAccessoryView = view

        configureLocationManager()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        findSuggestions()
        print(LocalAccess.vendorStore.query(text))
    }
}

extension VendorTextField: SuggestionViewDelegate {
    func addSuggestion(_ suggestion: String) {
        self.text = suggestion
        self.resignFirstResponder()
    }
}

extension VendorTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        return true
    }
}

extension VendorTextField: CLLocationManagerDelegate {
    
    func configureLocationManager() {
        CLLocationManager.locationServicesEnabled()
        locationManager.delegate = self
        locationManager.desiredAccuracy = 1.0
        locationManager.distanceFilter = 100.0
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getLocation() {
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        mapRegion = MKCoordinateRegion(center: locationManager.location!.coordinate, span: span)
        findSuggestions()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            getLocation()
        default:
            return
        }
    }
    
    func findSuggestions() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = self.text
        if let region = mapRegion {
            request.region = region
            print(region.center)
        }
        
        let search = MKLocalSearch(request: request)
        search.start(completionHandler:
            { localSearchResponse, error in
                var temp: [String] = []
                if error == nil {
                    guard let response = localSearchResponse else {
                        return
                    }
                    
                    for item in response.mapItems {
                        if let name = item.name {
                            temp.append(name)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.view.suggestions = temp
                        self.view.addSuggestions(temp)
                    }
                }
        })
    }
}
