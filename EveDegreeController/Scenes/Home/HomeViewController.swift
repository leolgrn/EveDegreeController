//
//  HomeViewController.swift
//  IOTController
//
//  Created by Léo LEGRON on 22/12/2019.
//  Copyright © 2019 Léo LEGRON. All rights reserved.
//

import UIKit
import HomeKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var accessoryTableView: UITableView!
    var accessories = [HMAccessory]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.accessoryTableView.dataSource = self
        self.accessoryTableView.delegate = self
        SharedHomeManager.default.manager.delegate = self
        self.navigationItem.title = "Home"
        
    }
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.accessories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.accessories[indexPath.row].name
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(EveDegreeViewController.newInstance(accessory:  self.accessories[indexPath.row]), animated: true)
    }

}

extension HomeViewController: HMHomeManagerDelegate {
    func homeManagerDidUpdateHomes(_ manager: HMHomeManager) {
        SharedHomeManager.default.manager.homes.forEach { (home) in
            home.accessories.forEach { (accessory) in
                self.accessories.append(accessory)
            }
        }
        self.accessoryTableView.reloadData()
    }
}
