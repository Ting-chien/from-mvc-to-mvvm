//
//  ViewController.swift
//  begin
//
//  Created by Ting-Chien Wang on 2021/3/30.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
    
    let imageDownloadQueue = OperationQueue()
    var menuHandlers: [MenuHandler] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        downloadMenu()
    }

    func downloadMenu() {
        
        let url = URL(string: "https://api.airtable.com/v0/appni65Bpbng3St79/Menu")!
        let apiKey = "keyi6ws4AJe5dE8tn"
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data,
               let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let records = json["records"] as? [[String: Any]] {
                self.menuHandlers.append(contentsOf: MenuHandler.parseResults(records))
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                print(error?.localizedDescription ?? "error request...")
            }
        }.resume()
    }
    
    // MARK: - tableview delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuHandlers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        
        let handler = menuHandlers[indexPath.row]
        cell.name.text = handler.name
        cell.price.text = "售價：$\(handler.price)"
        getImage(url: handler.imageUrl, at: indexPath, cell: cell)
        
        return cell
    }
    
    // MARK: - image downloader
    func getImage(url: URL, at indexPath: IndexPath, cell: UITableViewCell) {
        imageDownloadQueue.addOperation {
           do {
               let data = try Data(contentsOf: url)
               let image = UIImage(data: data)
               DispatchQueue.main.async {
                    guard let listCell = cell as? MenuTableViewCell else { return }
                    listCell.icon.image = image
                    listCell.setNeedsLayout()
               }
           } catch let error {
                print(error.localizedDescription)
           }
        }
    }
}

