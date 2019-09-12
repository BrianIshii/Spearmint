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

    var view: SuggestionsView?
    var suggestionViewDelegate: SuggestionViewDelegate? {
        didSet {
            guard let suggestionViewDelegate = suggestionViewDelegate else { return }
            
            view?.delegate = suggestionViewDelegate
        }
    }
    var mapRegion: MKCoordinateRegion?
    
    override init(frame: CGRect) {
        view = SuggestionsView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 45))
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        view = SuggestionsView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 45))

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
        
        let view = SuggestionsView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 45))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        view.frame.size.width = self.frame.width
        view.delegate = self
        self.inputAccessoryView = view
        self.view = view
        configureLocationManager()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard textField.text != nil else { return }
        
        findSuggestions()
        //print(LocalAccess.vendorStore.query(text))
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
        guard let text = self.text else { return }
        request.naturalLanguageQuery = text
        if let region = mapRegion {
            request.region = region
            print(region.center)
        }
        
        let search = MKLocalSearch(request: request)
        search.start(completionHandler:
            { localSearchResponse, error in
                var temp: [Suggestion] = []

                guard let vendorRepository = AppDelegate.container.resolve(VendorRepository.self) else {
                    print("failed to resolve \(VendorRepository.self)")
                    return
                }
                
                if error != nil {
                    for item in vendorRepository.queryVendors(text) {
                        temp.append(Suggestion(text: item.0, textColor: .blue, backgroundColor: .black))
                    }
                } else {
                    guard let response = localSearchResponse else {
                        return
                    }
                    
                    for item in vendorRepository.queryVendors(text) {
                        temp.append(Suggestion(text: item.0, textColor: .blue, backgroundColor: .black))
                    }

                    for item in response.mapItems {
                        if let name = item.name {
                            temp.append(Suggestion(text: name))
                        }
                    }
                    

                }
                DispatchQueue.main.async {
                    self.view?.addSuggestions(temp)
                }
        })
    }
}
