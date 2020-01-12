//
//  EveDegreeTemperatureViewController.swift
//  IOTController
//
//  Created by Léo LEGRON on 24/12/2019.
//  Copyright © 2019 Léo LEGRON. All rights reserved.
//

import UIKit
import HomeKit
import RealmSwift
import Charts

class EveDegreeTemperatureViewController: UIViewController {
    
    var selectedService: HMService!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var lineChart: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setChartData()
        
        let temperature = self.getTemperature()
        temperature?.readValue(completionHandler: { (err) in
            if err != nil {
                 print(err!.localizedDescription)
            } else {
               if let temperatureValue = (temperature?.value as? NSNumber)?.floatValue {
                    self.currentTemperatureLabel.text = "\(String(format: "%.1f", temperatureValue)) °C"
                    let temperature = Temperature()
                    temperature.value = temperatureValue
                    temperature.save()
                }
            }
        })
    }
    
    func getTemperature() -> HMCharacteristic? {
        return self.selectedService.characteristics.first { $0.characteristicType == HMCharacteristicTypeCurrentTemperature}
    }
    
    func setChartData(){
        let realm = try! Realm()
        let temperatures = realm.objects(Temperature.self)
        
        let data = self.getChartData(temperatures: temperatures)
        
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
    
    private func getChartData(temperatures: Results<Temperature>) -> ChartData {
        var values: [ChartDataEntry] = []
        
        temperatures.forEach({ (i) in
            values.append(ChartDataEntry(x: Double(i.date.timeIntervalSince1970), y: Double(round(i.value*10)/10)))
        })
        
        let chartDataSet = LineChartDataSet(entries: values, label: "Temperature")
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
