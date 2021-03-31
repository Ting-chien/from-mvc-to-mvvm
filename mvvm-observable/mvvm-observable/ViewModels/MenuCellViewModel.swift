//
//  MenuCellViewModel.swift
//  mvvm-closure
//
//  Created by Ting-Chien Wang on 2021/3/30.
//

import UIKit

class MenuCellViewModel {
    
    struct Events {
        var onImageDownloaded: Observable<UIImage?>
        var onNameChanged: Observable<String>
        var onPriceChanged: Observable<String>
        var onRequestFail: Observable<Error>?
    }
    
    private var menuHandler: MenuHandler
    var events: Events
    
    private let imageDownloadQueue = OperationQueue()
    
    init(_ model: MenuHandler, observableFail: Observable<Error>? = nil) {
        self.menuHandler = model
        events = Events(onImageDownloaded: Observable(nil),
                        onNameChanged: Observable(menuHandler.name),
                        onPriceChanged: Observable(menuHandler.price),
                        onRequestFail: observableFail)
        
        getImage(url: menuHandler.imageUrl)
    }
    
    func getImage(url: URL) {
        imageDownloadQueue.addOperation { [weak self] in
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                self?.events.onImageDownloaded.value = image!
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func clearOnReuse() {
        events.onNameChanged.bind(valueChanged: nil)
        events.onImageDownloaded.bind(valueChanged: nil)
        events.onPriceChanged.bind(valueChanged: nil)
        events.onRequestFail?.bind(valueChanged: nil)
    }
}
