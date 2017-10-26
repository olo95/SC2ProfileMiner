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
    var chartView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chartView = BarChartView(frame: view.frame)
        chartView.data = viewModel.setGraphData()
        view.addSubview(chartView)
        chartView.notifyDataSetChanged()
        // Do any additional setup after loading the view.
    }

}
