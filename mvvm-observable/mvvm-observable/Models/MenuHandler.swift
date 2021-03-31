//
//  MenuHandler.swift
//  from-mvc-to-mvvm
//
//  Created by Ting-Chien Wang on 2021/3/30.
//

import Foundation

struct MenuHandler: Codable {
    
    let name: String
    let price: String
    let imageUrl: URL
    
    static func parseResults(_ records: [[String: Any]]) -> [MenuHandler] {
        
        var menuHandlers = [MenuHandler]()
        
        for record in records {
            if let fields = record["fields"] as? [String: Any] {
                let name = fields["name"] as! String
                let price = fields["price"] as! String
                if let image = fields["image"] as? [[String: Any]],
                   let imageData = image.first,
                   let imageUrlString = imageData["url"] as? String {
                    let imageUrl = URL(string: imageUrlString)!
                    menuHandlers.append(MenuHandler(name: name,
                                                    price: price,
                                                    imageUrl: imageUrl))
                }
            }
        }
        
        return menuHandlers
    }
}
