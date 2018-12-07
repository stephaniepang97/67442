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
	
	@IBOutlet weak var loadingBackdrop : UIView!
	@IBOutlet weak var loadingCloud1 : UIImageView!
	@IBOutlet weak var loadingCloud2 : UIImageView!
	@IBOutlet weak var loadingCloud3 : UIImageView!
	
	let loadingObject = LoadingScreen()
	var loaded = false
	var secondsElapsed = 0
	var timer = Timer()
  
	@IBOutlet var barChartView: BarChartView!
	@IBOutlet var customTabBarView: UIView!
	@IBOutlet var userLabel: UILabel!
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
			if let name = currentData["name"].string {
				userLabel.text = name
			}
			// reverse for bar chart ordering
			self.sessions = sessions.reversed()
			loadGraph()
      self.tableView.reloadData()
			self.loaded = true
		}
		
		
	}

	
	override func viewDidLoad() {
		// start loading screen
		startLoadingScreen()
		
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
    
    self.tableView.delegate = self
    let cellNib = UINib(nibName: "SessionTableCell", bundle: nil)
    self.tableView.register(cellNib, forCellReuseIdentifier: "sessionTableCell")
	}
  
  
  // MARK: - Table View properties
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.sessions.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "sessionTableCell", for: indexPath) as! SessionTableCell
    
    let n = self.sessions.count-1
    let session = self.sessions[n-indexPath.row]
    // Configure the cell...
    let formatter = DateFormatter()
    // initially set the format based on your datepicker date / server String
    formatter.dateFormat = "EEEE, MMM d, h:mm a"
    let timeString = formatter.string(from: session.startTime!)
    
    cell.startTime?.text = timeString
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.performSegue(withIdentifier: "showSessionDetail", sender: tableView)
  }
	
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
  }
  
  // MARK: - Bar Chart
  private func loadGraph() {
    barChartView.noDataText = "No patient data available"
    
    var xLabels : [String] = []
    for session in self.sessions {
      let formatter = DateFormatter()
      // initially set the format based on your datepicker date / server String
      formatter.dateFormat = "hh:mm a\nMM/dd/yyyy"
      let timeString = formatter.string(from: session.endTime!)
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
	
	
  // MARK: - Navigation
  @IBAction func unwindToProgress(segue: UIStoryboardSegue) {
  }
	
	
	// loading screen
	func startLoadingScreen() {
		loadingBackdrop.isHidden = false
		loadingCloud1.isHidden = true
		loadingCloud2.isHidden = true
		loadingCloud3.isHidden = true
		self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateLoading), userInfo: nil, repeats: true)
	}
	
	@objc func updateLoading(){
		print(self.loaded)
		// still loading
		if (!self.loaded) {
			self.secondsElapsed = (self.secondsElapsed + 1) % 100
			var cloudsDisplay = loadingObject.calculateVisibleClouds(currentSeconds: self.secondsElapsed)
			print(self.secondsElapsed)
			// adjust cloud display based on seconds passed
			switch (cloudsDisplay) {
			case 1:
				loadingBackdrop.isHidden = false
				loadingCloud1.fadeIn()
				loadingCloud2.isHidden = true
				loadingCloud3.isHidden = true
			case 2:
				loadingBackdrop.isHidden = false
				loadingCloud1.isHidden = false
				loadingCloud2.fadeIn()
				loadingCloud3.isHidden = true
			case 3:
				loadingBackdrop.isHidden = false
				loadingCloud1.isHidden = false
				loadingCloud2.isHidden = false
				loadingCloud3.fadeIn()
			default:
				loadingBackdrop.isHidden = false
				loadingCloud1.isHidden = false
				loadingCloud2.isHidden = false
				loadingCloud3.isHidden = false
			}
		}
			// done loading, hide everything
		else {
			loadingBackdrop.fadeOut()
			loadingBackdrop.isHidden = true
			loadingCloud1.isHidden = true
			loadingCloud2.isHidden = true
			loadingCloud3.isHidden = true
		}
		
	}
	
	
}
