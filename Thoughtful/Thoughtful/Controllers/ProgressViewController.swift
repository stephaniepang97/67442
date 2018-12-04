//
//  ProgressViewController.swift
//  Thoughtful
//
//  Created by Alec Lam on 12/4/18.
//  Copyright © 2018 Stephanie Pang. All rights reserved.
//

import Foundation
import Charts


class ProgressViewController: UIViewController  {
	@IBOutlet var chartView: BarChartView!
	
	var months: [String]!
	
	override func viewDidLoad() {
		
		chartView.noDataText = "No patient data available"
	
		months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
		let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
		
		setChart(dataPoints: months, values: unitsSold)

	}
	
	func setChart(dataPoints: [String], values: [Double]) {
		var dataEntries: [BarChartDataEntry] = Array()
		var counter = 0.0
		
		for i in 0..<dataPoints.count {
			counter += 1.0
			let dataEntry = BarChartDataEntry(x: values[i], y: counter)
			dataEntries.append(dataEntry)
		}
		
		let chartDataSet = BarChartDataSet(values: dataEntries, label: "Time")
		let chartData = BarChartData()
		chartData.addDataSet(chartDataSet)
		chartView.data = chartData
	}
	
	
	
	
}
