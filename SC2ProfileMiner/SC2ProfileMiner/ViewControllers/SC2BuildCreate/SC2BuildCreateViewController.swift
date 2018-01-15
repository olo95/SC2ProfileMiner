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
    
    @IBOutlet weak var saveBuildButton: UIButton!
    @IBOutlet weak var buildTableView: UITableView!
    var viewModel: SC2BuildCreateViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUI()
        bindUI()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = ColorTheme.appTheme.base
        navigationItem.rightBarButtonItems = [UIBarButtonItem(image: #imageLiteral(resourceName: "hamburger"), style: .done, target: self, action: #selector(editCells)), UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .done, target: self, action: #selector(createNewCell))]
        navigationItem.rightBarButtonItems?.forEach {
            $0.image = $0.image!.withRenderingMode(.alwaysTemplate)
            $0.tintColor = ColorTheme.appTheme.base
        }
    }
    
    private func setupUI() {
        registerNibs()
        setupTableView()
        setupButtons()
    }
    
    private func registerNibs() {
        buildTableView.register(UINib(nibName: SC2BuildTableViewCell.typeName,
                                       bundle: nil), forCellReuseIdentifier: SC2BuildTableViewCell.typeName)
    }
    
    private func setupTableView() {
        buildTableView.rowHeight = buildTableView.frame.height / 6
        buildTableView.layoutIfNeeded()
        buildTableView.allowsSelection = false
        buildTableView.isEditing = false
    }
    
    private func setupButtons() {
        saveBuildButton.layer.add(CABasicAnimation().pulseAnimation(duration: 2), forKey: "animateOpacity")
        saveBuildButton.rx.tap.subscribe( onNext: { _ in
            self.viewModel.flowDelegate.buildRouter.onNext(.showBuildSave(buildCellsData: self.viewModel.buildCells.value, name: self.viewModel.nameOfBuild))
        }).disposed(by: viewModel.bag)
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
            cell.backgroundColor = ColorTheme.appTheme.lightBase
            return cell
        }.disposed(by: viewModel.bag)
        
        buildTableView.rx.itemMoved.subscribe( onNext: { indexPath in
            
        }).disposed(by: viewModel.bag)
        
        buildTableView.rx.itemDeleted.subscribe( onNext: { indexPath in
            self.viewModel.buildCells.value.remove(at: indexPath.row)
        }).disposed(by: viewModel.bag)
    }
    
    @objc
    private func createNewCell() {
        viewModel.flowDelegate.buildRouter.onNext(.showCellCreator)
    }
    
    @objc
    private func editCells() {
        buildTableView.isEditing = true
        navigationItem.rightBarButtonItems![0] = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(endEditingCells))
    }
    
    @objc
    private func endEditingCells() {
        buildTableView.isEditing = false
        navigationItem.rightBarButtonItems![0] = UIBarButtonItem(image: #imageLiteral(resourceName: "hamburger"), style: .done, target: self, action: #selector(editCells))
    }

}
