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
	@IBOutlet var barChartView: BarChartView!
	
	@IBOutlet var customTabBarView: UIView!

	
	var months: [String]!
	
	
	@IBAction func unwindToHomeQuizView(segue: UIStoryboardSegue) {
	}
	
	override func viewDidLoad() {
		
		// load graph
		
		barChartView.noDataText = "No patient data available"
	
		months = ["Jan", "Feb", "Mar"]
		let unitsSold = [0.0, 1.0, 2.0]
		// set data
		setChart(dataPoints: months, values: unitsSold)
		barChartView.minOffset = 25
		barChartView.scaleXEnabled = false
		barChartView.scaleYEnabled = false

		barChartView.extraTopOffset = -50
		barChartView.xAxis.labelFont = UIFont.init(name: "Futura", size: 10)!
		barChartView.leftAxis.labelFont = UIFont.init(name: "Futura", size: 10)!
		barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values:months)
		barChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
		barChartView.leftAxis.drawGridLinesEnabled = false
		barChartView.xAxis.drawGridLinesEnabled = false
		barChartView.rightAxis.enabled = false
		
		barChartView.leftAxis.axisMinimum = 0.0
		barChartView.leftAxis.axisMaximum = 100.0
		
		barChartView.legend.enabled = false


		
		// Do any additional setup after loading the view.
		customTabBarView.frame.size.width = self.view.frame.width
		customTabBarView.frame.origin.y = self.view.frame.height-customTabBarView.frame.height
		customTabBarView.backgroundColor = UIColor(white: 1, alpha: 0)
		self.view.addSubview(customTabBarView)
	}
	
	func setChart(dataPoints: [String], values: [Double]) {
		var dataEntries: [BarChartDataEntry] = Array()
		var counter = 0.0
		var red : UIColor = UIColor(red: 1, green: 132/255, blue: 153/255, alpha: 1)
		var green : UIColor = UIColor(red: 141/255, green: 220/255, blue: 133/255, alpha: 1)

		var barColors : Array<UIColor> = []
		for i in 0..<dataPoints.count {
			print("set")
			
			var value = 0.0
			switch (i) {
				case 0:
					value = 40.0
				case 1:
					value = 100.0
				default:
					value = 65.0
			}
			if (value < 50.0) {
				barColors.append(red) // red
			} else {
				barColors.append(green) // green
			}
			
			let dataEntry = BarChartDataEntry(x: values[i], y: value)
			dataEntries.append(dataEntry)
		}
		
		let chartDataSet = BarChartDataSet(values: dataEntries, label: "Time")
		chartDataSet.colors = barColors
		chartDataSet.highlightEnabled = false
		chartDataSet.valueFont = UIFont.init(name: "Futura", size: 8)!
		let chartData = BarChartData()
		chartData.addDataSet(chartDataSet)
		barChartView.data = chartData
		barChartView.fitScreen()
		barChartView.notifyDataSetChanged()
	}
	
	
	
	
}
