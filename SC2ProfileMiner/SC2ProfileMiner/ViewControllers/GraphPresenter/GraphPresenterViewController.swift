//
//  GraphPresenterViewController.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 26.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import RxSwift
import RxCocoa
import Charts

class GraphPresenterViewController: UIViewController {

    var viewModel: GraphPresenterViewModel!
    var chartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chartView = LineChartView(frame: view.frame)
        viewModel.setGraphData() { graphData in
            var dataEntries: [ChartDataEntry] = []
            dataEntries = graphData.map( {
                let dataEntry = ChartDataEntry(x: Double($0.1), y: $0.0 == "WIN" ? 1 : 0)
                return dataEntry
            })
            
            let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "Match history")
            let lineChartData = LineChartData(dataSets: [lineChartDataSet])
            self.chartView.data = lineChartData
            self.chartView.animate(xAxisDuration: 2.0)
            self.chartView.borderLineWidth = 2.0
            
            self.view.addSubview(self.chartView)
            self.chartView.notifyDataSetChanged()
        }
    }

}
