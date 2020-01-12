//
//  EveDegreeHumidityViewController.swift
//  EveDegreeController
//
//  Created by Léo LEGRON on 03/01/2020.
//  Copyright © 2020 Léo LEGRON. All rights reserved.
//

import UIKit
import HomeKit
import RealmSwift
import Charts

class EveDegreeHumidityViewController: UIViewController {
    
    var selectedService: HMService!
    @IBOutlet weak var currentHumidityLabel: UILabel!
    @IBOutlet weak var lineChart: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setChartData()
        
        let humidity = self.getHumidity()
        humidity?.readValue(completionHandler: { (err) in
            if err != nil {
                print(err!.localizedDescription)
            } else {
               if let humidityValue = (humidity?.value as? NSNumber)?.floatValue {
                    self.currentHumidityLabel.text = "\(String(format: "%.1f", humidityValue)) %"
                    let humidity = Humidity()
                    humidity.value = humidityValue
                    humidity.save()
                }
            }
        })
    }
    
    func getHumidity() -> HMCharacteristic? {
        return self.selectedService.characteristics.first { $0.characteristicType == HMCharacteristicTypeCurrentRelativeHumidity }
    }
    
    private func setChartData(){
        let realm = try! Realm()
        let humidity = realm.objects(Humidity.self)
        
        let data = self.getChartData(humidity: humidity)
        
        let xaxis: XAxis = XAxis()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "dd/MM"
        
        let charXAxisFormatter = ChartXAxisFormatter(dateFormatter: dateFormatter)
        
        xaxis.valueFormatter = charXAxisFormatter
        self.lineChart.xAxis.valueFormatter = xaxis.valueFormatter
        
        self.lineChart.xAxis.labelPosition = .bottom
        self.lineChart.rightAxis.drawLabelsEnabled = false
        self.lineChart.xAxis.drawGridLinesEnabled = false

        self.lineChart.data = data
    }
    
    private func getChartData(humidity: Results<Humidity>) -> ChartData {
        var values: [ChartDataEntry] = []
        
        humidity.forEach({ (item) in
            values.append(ChartDataEntry(x: item.date.timeIntervalSince1970, y: Double(round(item.value*10)/10)))
        })
        
        let chartDataSet = LineChartDataSet(entries: values, label: "Humidity")
        chartDataSet.drawIconsEnabled = false
        
        chartDataSet.setColor(.blue)
        chartDataSet.drawValuesEnabled = false
        
        let gradientColors = [ChartColorTemplates.colorFromString("#0000ff").cgColor,
                              ChartColorTemplates.colorFromString("#ffffff").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        
        chartDataSet.fillAlpha = 1
        chartDataSet.fill = Fill(linearGradient: gradient, angle: 90)
        chartDataSet.drawFilledEnabled = true
        
        let chartData = LineChartData()
        chartData.addDataSet(chartDataSet)
        return chartData
    }
}
