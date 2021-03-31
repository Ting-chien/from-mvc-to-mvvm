//
//  MainViewModel.swift
//  mvvm-closure
//
//  Created by Ting-Chien Wang on 2021/3/30.
//

import UIKit

class MainViewModel {
    
    private var menuHandlers: [MenuHandler] = []
    public private(set) var menuCellViewModels: [MenuCellViewModel] = []
    
    // on completion outputs
    var onRequestEnd: Observable<Void> = Observable(())
    var onRequestFail: Observable<Error>?
    
    init() {
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
                self.convertMenuToViewModel(menus: self.menuHandlers)
                print("request success.....................")
            } else {
                self.onRequestFail!.value = error!
            }
        }.resume()
    }
    
    private func convertMenuToViewModel(menus: [MenuHandler]) {
        for menu in menus {
            let menuCellViewModel = MenuCellViewModel(menu, observableFail: onRequestFail)
            menuCellViewModels.append(menuCellViewModel)
        }
        onRequestEnd.value = ()
    }
}
