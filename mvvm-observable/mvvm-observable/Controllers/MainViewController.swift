//
//  MainViewController.swift
//  mvvm-closure
//
//  Created by Ting-Chien Wang on 2021/3/30.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let nib = UINib(nibName: "MenuTableViewCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "MenuTableViewCell")
            tableView.estimatedRowHeight = 88
            tableView.rowHeight = UITableView.automaticDimension
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bindViewModel()
    }
    
    func bindViewModel() {
        viewModel.onRequestEnd.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.menuCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        
        let menuCellViewModel = viewModel.menuCellViewModels[indexPath.row]
        cell.setup(viewModel: menuCellViewModel)
        
        return cell
    }
}

