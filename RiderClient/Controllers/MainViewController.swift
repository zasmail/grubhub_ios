//
//  MainViewController.swift
//  RiderClient
//
//  Created by Neo Ighodaro on 12/02/2018.
//  Copyright © 2018 CreativityKills Co. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import PusherSwift

class MainViewController: UIViewController, GMSMapViewDelegate {
    var params:String?
    
    let pusher = Pusher(
        key: AppConstants.PUSHER_KEY,
        options: PusherClientOptions(host: .cluster(AppConstants.PUSHER_CLUSTER))
    )

    var latitude = 37.388064
    var longitude = -122.088426

    var locationMarker: GMSMarker!
    var driverlocationMarker: GMSMarker!

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingOverlay: UIView!

    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var orderStatusView: UIView!
    @IBOutlet weak var orderStatus: UILabel!
    @IBOutlet weak var cancelButton: UIButton!

    @IBOutlet weak var driverDetailsView: UIView!
    @IBOutlet weak var driverName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.camera = GMSCameraPosition.camera(withLatitude:latitude, longitude:longitude, zoom:15.0)
        mapView.delegate = self
        locationMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        locationMarker.title = "You"
        locationMarker.map = mapView

        driverlocationMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: 0, longitude: 0))
        driverlocationMarker.icon = GMSMarker.markerImage(with: UIColor.blue)
        driverlocationMarker.title = "Driver"
        driverlocationMarker.map = nil

        orderStatusView.layer.cornerRadius = 5
        orderStatusView.layer.shadowOffset = CGSize(width: 0, height: 0)
        orderStatusView.layer.shadowColor = UIColor.black.cgColor
        orderStatusView.layer.shadowOpacity = 0.3
        
        updateView(status: .Neutral, inputDriverName: "John Doe", msg: nil)
        listenForUpdates()
    }
    
    @IBAction func orderButtonPressed(_ sender: Any) {
        updateView(status: .Searching, inputDriverName: "John Doe", msg: nil)
        sendRequest(.post) { successful in
            guard successful else {
                return self.updateView(status: .Neutral, inputDriverName: "", msg: "😔 No drivers available.")
            }
        }
    }

    @IBAction func cancelButtonPressed(_ sender: Any) {
//        sendRequest(.delete) { successful in
//            guard successful == false else {
//                return self.updateView(status: .Neutral, inputDriverName: "", msg: nil)
//            }
//        }
    }
    
    private func updateView(status: RideStatus, inputDriverName: String?, msg: String?) {
        
        driverName.text = inputDriverName
        switch status {
        case .Neutral:
            driverDetailsView.isHidden = true
            loadingOverlay.isHidden = true
            orderStatus.text = msg != nil ? msg! : "💡 Tap the button below to place order."
            orderButton.setTitleColor(UIColor.white, for: .normal)
            orderButton.isHidden = false
            cancelButton.isHidden = true
            loadingIndicator.stopAnimating()
            
        case .Searching:
            loadingOverlay.isHidden = false
            orderStatus.text = msg != nil ? msg! : "🚕 Looking for a driver."
            orderButton.setTitleColor(UIColor.clear, for: .normal)
            loadingIndicator.startAnimating()

        case .FoundRide, .Arrived:
            driverDetailsView.isHidden = false
            loadingOverlay.isHidden = true
            
            if status == .FoundRide {
                orderStatus.text = msg != nil ? msg! : "😎 Driver has food and is on the way"
            } else {
                orderStatus.text = msg != nil ? msg! : "⏰ Your driver is waiting, please meet outside."
            }
            
            orderButton.isHidden = true
            cancelButton.isHidden = false
            loadingIndicator.stopAnimating()

        case .OnTrip:
            orderStatus.text = msg != nil ? msg! : "🙂 Driver has picked up food."
            cancelButton.isEnabled = false

        case .EndedTrip:
            orderStatus.text = msg != nil ? msg! : "🌯 Drop-off complete. Have a nice day!"
            orderButton.setTitleColor(UIColor.white, for: .normal)
            driverDetailsView.isHidden = true
            cancelButton.isEnabled = true
            orderButton.isHidden = false
            cancelButton.isHidden = true
        }
    }
    
    private func sendRequest(_ method: HTTPMethod, handler: @escaping(Bool) -> Void) {
        Alamofire.request(AppConstants.API_URL + "/requests", method: method, parameters: ["user_id": AppConstants.USER_ID])
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess,
                    let data = response.result.value as? [String:Bool],
                    let status = data["status"] else { return handler(false) }
                
                handler(status)
            }
    }
    
    private func listenForUpdates() {
        let channel = pusher.subscribe("cabs")
        
        let _ = channel.bind(eventName: "status-update") { data in
            if let data = data as? [String:AnyObject] {
//                if let latitude = data["driver_latitude"] as? Double {
//                    if let longitude = data["driver_longitude"] as? Double {
//                        print(longitude)
//                        self.driverlocationMarker.map = nil
//                        self.driverlocationMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
//                        self.driverlocationMarker.map = self.mapView
//                    }
//                }
                let latitude = data["driver_latitude"] as? Double
                let longitude = data["driver_longitude"] as? Double

                self.driverlocationMarker.map = nil
                self.driverlocationMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: latitude ?? 0, longitude: longitude ?? 0))
                self.driverlocationMarker.icon = UIImage(named: "gh-icon")

                self.driverlocationMarker.map = self.mapView
                if let status = data["status"] as? String, let rideStatus = RideStatus(rawValue: status) {
                    self.updateView(status: rideStatus, inputDriverName: data["driver_name"] as? String, msg: nil)

//                    locationMarker.map = mapView
                }
            }
        }
        
        pusher.connect()
    }
    
//    -------------------------
    @IBOutlet weak var tabelView: UITableView!
    
    

}
