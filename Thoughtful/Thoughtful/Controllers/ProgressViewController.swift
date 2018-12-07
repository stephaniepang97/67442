//
//  ProgressViewController.swift
//  Thoughtful
//
//  Created by Alec Lam on 12/4/18.
//  Copyright © 2018 Stephanie Pang. All rights reserved.
//

import Foundation
import Charts
import SwiftyJSON


class ProgressViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
  
	@IBOutlet var barChartView: BarChartView!
	@IBOutlet var customTabBarView: UIView!
  @IBOutlet var tableView: UITableView!

	var analyticsObject : UserAnalyticsViewModel!
	var familyName : String!

	var months: [String]!
	
	var sessions : [Session] = []
	
	func configureView() -> Void {
		// Update the user interface for the detail item.
		if let data: UserAnalyticsViewModel = self.analyticsObject {
			var currentData : JSON = data.currentData
			var sessions : [Session] = currentData["recent_sessions"].arrayObject! as! [Session]
			var incorrect_questions : [SessionQuestion] = currentData["incorrect_questions"].arrayObject! as! [SessionQuestion]
			for session in sessions {
				print(session.percentCorrect)
			}
			// reverse for bar chart ordering
			self.sessions = sessions.reversed()
//			self.loaded = true
			loadGraph()
		}
	}
	
	private func loadGraph() {
		barChartView.noDataText = "No patient data available"
		
		var xLabels : [String] = []
		for session in self.sessions {
			let formatter = DateFormatter()
			// initially set the format based on your datepicker date / server String
			formatter.dateFormat = "hh:mm a\nMM/dd/yyyy"
			let timeString = formatter.string(from: session.endTime!) // string purpose I add here
			xLabels.append(timeString)
		}
		let unitsSold = [0.0, 1.0, 2.0]
		// set data
		setChart(dataPoints: xLabels, values: unitsSold)
		barChartView.minOffset = 30
		barChartView.scaleXEnabled = false
		barChartView.scaleYEnabled = false
		
		barChartView.extraTopOffset = -50
		barChartView.xAxis.labelFont = UIFont.init(name: "Futura", size: 10)!
		barChartView.leftAxis.labelFont = UIFont.init(name: "Futura", size: 10)!
		barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values:xLabels)
		barChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
		barChartView.leftAxis.drawGridLinesEnabled = false
		barChartView.xAxis.drawGridLinesEnabled = false
		barChartView.rightAxis.enabled = false
		
		barChartView.leftAxis.axisMinimum = 0.0
		barChartView.leftAxis.axisMaximum = 100.0
		
		barChartView.legend.enabled = false
	}
	
	override func viewDidLoad() {
		
		
		// get the data
		analyticsObject.refresh { [unowned self] in
			DispatchQueue.main.async {
				self.analyticsObject.getPatientDataFromFamilyName(familyName: self.familyName, completion: self.configureView)
			}
		}
		// load graph
		
		loadGraph()

		// Do any additional setup after loading the view.
		customTabBarView.frame.size.width = self.view.frame.width
		customTabBarView.frame.origin.y = self.view.frame.height-customTabBarView.frame.height
		customTabBarView.backgroundColor = UIColor(white: 1, alpha: 0)
		self.view.addSubview(customTabBarView)
    
    let cellNib = UINib(nibName: "SessionTableCell", bundle: nil)
    tableView.register(cellNib, forCellReuseIdentifier: "sessionTableCell")
	}
  
  // MARK: - Table View properties
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    sessions.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "sessionTableCell", for: indexPath) as! SessionTableCell
    
    let session = sessions[indexPath.row]
    // Configure the cell...
    cell.startTime?.text = session.startTime
    cell.endTime?.text = session.endTime
    
    return cell
  }
	
  // MARK: - Bar Chart
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
					value = self.sessions[0].percentCorrect
				case 1:
					value = self.sessions[1].percentCorrect
				default:
					value = self.sessions[2].percentCorrect
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
