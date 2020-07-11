//
//  OptionsFormCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 5/25/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import GooglePlacesSearchController

class OptionsFormCell: UITableViewCell, GooglePlacesAutocompleteViewControllerDelegate {


    //MARK: IBOUTLETS
    
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var Quantity: UITextField!
    @IBOutlet weak var SwitchDeal: UISwitch!
    @IBOutlet weak var SwitchConflict: UISwitch!
    @IBOutlet weak var SwitchAddr: UISwitch!
    
    //MARK: OTHER VARIABLES
//    var didSelectPlace:(()->Void)! = nil
    let GoogleMapsAPIServerKey = "AIzaSyD7ZIdLTcp9ECQHsWr09nipuyWGxjOx964"
    var controller = GooglePlacesSearchController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewSearch.isHidden = true
        Quantity.keyboardType = .numberPad
//        searchbar.delegate = self
        controller = GooglePlacesSearchController(delegate: self,
                                                  apiKey: GoogleMapsAPIServerKey,
                                                  placeType: .address
            // Optional: coordinate: CLLocationCoordinate2D(latitude: 55.751244, longitude: 37.618423),
            // Optional: radius: 10,
            // Optional: strictBounds: true,
            // Optional: searchBarPlaceholder: "Start typing..."
        )
        viewSearch.addSubview(controller.searchBar)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func Auction(_ sender: UISwitch) {
        if sender.isOn{
            PushJobViewModel.result!.dealable = 1
        }
    }
    @IBAction func Conflict(_ sender: UISwitch) {
    }
    @IBAction func placeWork(_ sender: UISwitch) {
        if sender.isOn {
          viewSearch.isHidden = false
        } else {
          viewSearch.isHidden = true
        }
    }
    func viewController(didAutocompleteWith place: PlaceDetails) {
        
        
        print(place.description)
        
        PushJobViewModel.result!.address = place.formattedAddress
        PushJobViewModel.result!.area_province = place.administrativeArea ?? ""
        PushJobViewModel.result!.area_district = place.subAdministrativeArea ?? ""
        
        PushJobViewModel.result!.lat = place.coordinate?.latitude as! Double
        PushJobViewModel.result!.lng = place.coordinate?.longitude as! Double
        controller.isActive = false
        controller.searchBar.text = place.description
    }
    @IBAction func change(_ sender: UITextField) {
        PushJobViewModel.result!.vacancy = sender.text ?? "1"
    }
    func bindData(_ data:TYPEJOBDETAIL){
        Quantity.text = "\(data.vacancy)"
        SwitchDeal.isOn = data.dealable
        SwitchConflict.isOn = true
        if data.address != ""{
            SwitchAddr.isOn = true
            viewSearch.isHidden = false
            controller.searchBar.text = data.address
        }
        
    }

}
