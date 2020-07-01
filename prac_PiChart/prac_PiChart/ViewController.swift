//
//  ViewController.swift
//  prac_PiChart
//
//  Created by 남수김 on 2020/07/02.
//  Copyright © 2020 남수김. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {

    @IBOutlet weak var pieChartView: PieChartView!
    
    var aDateEntry = PieChartDataEntry(value: 0)
    var bDateEntry = PieChartDataEntry(value: 0)
    
    var dataEntries = [PieChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pieChartView.chartDescription?.text = "description"
        
        aDateEntry.value = 10
        aDateEntry.label = "a"
        
        bDateEntry.value = 30
        bDateEntry.label = "b"
        
        dataEntries = [aDateEntry, bDateEntry]
        
        updateCharts()
        
        // 차트안의 라벨색
        pieChartView.entryLabelColor = .blue
        pieChartView.animate(yAxisDuration: 1.0, easingOption: .easeOutSine)
        
        
    }
    
    func updateCharts() {
        let chartDataSet = PieChartDataSet(entries: dataEntries, label: "label")
        // 데이터간 간격
        chartDataSet.sliceSpace = 10
        
        // 데이터 색
        let colors: [UIColor] = [.red, .orange]
        chartDataSet.colors = colors
        
        let chartData = PieChartData(dataSet: chartDataSet)
        // 차트안의 데이터 값색
        chartData.setValueTextColor(.cyan)
        
        pieChartView.data = chartData
    }
}
