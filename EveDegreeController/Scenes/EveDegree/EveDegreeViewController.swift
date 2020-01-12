//
//  EveDegreeViewController.swift
//  IOTController
//
//  Created by Léo LEGRON on 24/12/2019.
//  Copyright © 2019 Léo LEGRON. All rights reserved.
//

import UIKit
import HomeKit

class EveDegreeViewController: UIViewController {
    
    var selectedAccessory: HMAccessory!
    @IBOutlet weak var serviceTableView: UITableView!
    var displayedServices: [HMService] = [] {
        didSet {
            self.serviceTableView.reloadData()
        }
    }
    @IBOutlet weak var reachableLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(self.selectedAccessory.isReachable){
            self.navigationItem.title = "\(self.selectedAccessory.name) (disponible)"
        } else {
            self.navigationItem.title = "\(self.selectedAccessory.name) (hors de portée)"
        }
        self.serviceTableView.delegate = self
        self.serviceTableView.dataSource = self
        self.displayedServices = self.selectedAccessory.services.filter({ (service) -> Bool in
            return self.serviceMustBeDisplayed(service.serviceType)
        })
        self.selectedAccessory.delegate = self
    }
    
    class func newInstance(accessory: HMAccessory) -> EveDegreeViewController {
        let edvc = EveDegreeViewController()
        edvc.selectedAccessory = accessory
        return edvc
    }
    
    func getServiceType(_ serviceType: String) -> String {
        switch (serviceType){
        case HMServiceTypeHumiditySensor:
            return "Humidité"
        case HMServiceTypeTemperatureSensor:
            return "Température"
        default:
            return "Service inconnu"
        }
    }
    
    func serviceMustBeDisplayed(_ serviceType: String) -> Bool {
        if (
            serviceType == HMServiceTypeAccessoryInformation ||
            serviceType == HMServiceTypeBattery ||
            serviceType == "E863F00A-079E-48FF-8F27-9C2605A29F52" ||
            serviceType == "E863F007-079E-48FF-8F27-9C2605A29F52"
            ){
            return false
        } else {
            return true
        }
    }
}

extension EveDegreeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let service = self.displayedServices[indexPath.row]
        
        if((service.serviceType == HMServiceTypeTemperatureSensor) && service.accessory!.isReachable){
            let controller = EveDegreeTemperatureViewController()
            controller.selectedService = service
            self.navigationController?.pushViewController(controller, animated: true)
        } else if (service.serviceType == HMServiceTypeHumiditySensor && service.accessory!.isReachable){
            let controller = EveDegreeHumidityViewController()
            controller.selectedService = service
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

extension EveDegreeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.displayedServices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = getServiceType(self.displayedServices[indexPath.row].serviceType)
        return cell
    }
}

extension EveDegreeViewController: HMAccessoryDelegate {
    func accessoryDidUpdateReachability(_ accessory: HMAccessory) {
        if(accessory.isReachable){
            self.navigationItem.title = "\(self.selectedAccessory.name) (disponible)"
        } else {
            self.navigationItem.title = "\(self.selectedAccessory.name) (hors de portée)"
        }
    }
}
