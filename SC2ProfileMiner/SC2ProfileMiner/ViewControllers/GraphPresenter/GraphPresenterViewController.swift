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
        setupNavigationBar()
        graphSetup()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "SC2 Profile Miner"
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
        view.layoutIfNeeded()
    }
    
    private func createMatchHistoryGraph() {
        lineChartView = LineChartView(frame: view.frame)
        viewModel.setGraphData() { graphData in
            var dataEntries: [ChartDataEntry] = []
            dataEntries = graphData.map( {
                let dataEntry = ChartDataEntry(x: Double($0.1), y: $0.0 == "WIN" ? 1 : 0)
                return dataEntry
            })
            
            let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "Match history 1 = Win 0 = Loss")
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
            
            for (index, element) in graphData.enumerated() {
                dataEntries.append(ChartDataEntry(x: Double(index), y: Double(element.1)))
            }
            
            let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Wins and losses")
            let pieChartData = PieChartData(dataSets: [pieChartDataSet])
            self.pieChartView.data = pieChartData
            self.pieChartView.animate(xAxisDuration: 2.0)
            
            var colors: [UIColor] = []
            
            for _ in 0..<graphData.count {
                let red = Double(arc4random_uniform(256))
                let green = Double(arc4random_uniform(256))
                let blue = Double(arc4random_uniform(256))
                
                let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
                colors.append(color)
            }
            
            pieChartDataSet.colors = colors
            
            self.view.addSubview(self.pieChartView)
            self.pieChartView.notifyDataSetChanged()
        }
    }

}
