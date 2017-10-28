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
    var lineChartView: LineChartView!
    var pieChartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        graphSetup()
    }
    
    private func graphSetup() {
        switch viewModel.graphType {
        case .matchHistory:
            createMatchHistoryGraph()
        case .seasonWinsLosses:
            createSeasonWinsLossesGraph()
        default:
            break
        }
    }
    
    private func createMatchHistoryGraph() {
        lineChartView = LineChartView(frame: view.frame)
        viewModel.setGraphData() { graphData in
            var dataEntries: [ChartDataEntry] = []
            dataEntries = graphData.map( {
                let dataEntry = ChartDataEntry(x: Double($0.1), y: $0.0 == "WIN" ? 1 : 0)
                return dataEntry
            })
            
            let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "Match history")
            let lineChartData = LineChartData(dataSets: [lineChartDataSet])
            self.lineChartView.data = lineChartData
            self.lineChartView.animate(xAxisDuration: 2.0)
            self.lineChartView.borderLineWidth = 2.0
            
            self.view.addSubview(self.lineChartView)
            self.lineChartView.notifyDataSetChanged()
        }
    }
    
    private func createSeasonWinsLossesGraph() {
        pieChartView = PieChartView(frame: view.frame)
        viewModel.setGraphData() { graphData in
            var dataEntries: [ChartDataEntry] = []
            dataEntries = graphData.map( {
                let dataEntry = ChartDataEntry(x: Double($0.1), y: $0.0 == "WIN" ? 1 : 0)
                return dataEntry
            })
            
            let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Wins and losses")
            let pieChartData = PieChartData(dataSets: [pieChartDataSet])
            self.pieChartView.data = pieChartData
            self.pieChartView.animate(xAxisDuration: 2.0)
            
            self.view.addSubview(self.pieChartView)
            self.pieChartView.notifyDataSetChanged()
        }
    }

}
