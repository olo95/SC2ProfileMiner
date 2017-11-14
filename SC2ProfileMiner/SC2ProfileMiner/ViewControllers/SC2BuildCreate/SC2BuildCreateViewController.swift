//
//  SC2BuildCreateViewController.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 05.11.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import RxSwift
import RxCocoa

class SC2BuildCreateViewController: UIViewController {

    @IBOutlet weak var buildTableView: UITableView!
    var viewModel: SC2BuildCreateViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUI()
        bindUI()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "SC2 Profile Miner"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: ColorTheme.appTheme.gray]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add build element", style: .done, target: self, action: #selector(createNewCell))
    }
    
    private func setupUI() {
        registerNibs()
        setupTableView()
    }
    
    private func registerNibs() {
        buildTableView.register(UINib(nibName: SC2BuildTableViewCell.typeName,
                                       bundle: nil), forCellReuseIdentifier: SC2BuildTableViewCell.typeName)
    }
    
    private func setupTableView() {
        buildTableView.rowHeight = buildTableView.frame.height / 6
        buildTableView.layoutIfNeeded()
    }
    
    private func bindUI() {
        viewModel.buildCells.asObservable()
            .map {
                return $0.map { return BuildCellData($0.0, $0.1, $0.2) }.filter { return !$0.0.isEmpty && !$0.1.isEmpty && !$0.2.isEmpty }
            }
            .bind(to: buildTableView.rx.items) { tableView, index, element in
            let cell = tableView.dequeueReusableCell(withIdentifier: SC2BuildTableViewCell.typeName, for: IndexPath(row: index, section: 0)) as! SC2BuildTableViewCell
            cell.timeMomentLabel.text = element.time
            cell.actionLabel.text = element.action
            cell.descriptionLabel.text = element.description
            return cell
        }.disposed(by: viewModel.bag)
    }
    
    @objc
    private func createNewCell() {
        viewModel.flowDelegate.buildRouter.onNext(.showCellCreator)
    }

}
