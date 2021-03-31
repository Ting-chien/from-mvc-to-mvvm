//
//  MenuCellViewModel.swift
//  mvvm-closure
//
//  Created by Ting-Chien Wang on 2021/3/30.
//

import UIKit

class MenuCellViewModel {
    var name: String
    var price: String
    var imageUrl: URL
    
    // operations
    private let imageDownloadQueue = OperationQueue()
    
    var onImageDownloaded: ((UIImage?) -> Void)?
    
    init(name: String, price: String, imageUrl: URL) {
        self.name = name
        self.price = price
        self.imageUrl = imageUrl
    }

    func getImage() {
        imageDownloadQueue.addOperation { [weak self] in
            do {
                let data = try Data(contentsOf: self!.imageUrl)
                let image = UIImage(data: data)
                guard let imageDownloaded = self?.onImageDownloaded else { return }
                imageDownloaded(image)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
