//
//  MenuTableViewCell.swift
//  from-mvc-to-mvvm
//
//  Created by Ting-Chien Wang on 2021/3/30.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    private var viewModel: MenuCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        icon.image = nil
        self.viewModel?.onImageDownloaded = nil
    }
    
    func setup(viewModel: MenuCellViewModel) {
        
        self.viewModel = viewModel
        
        self.name.text = viewModel.name
        self.price.text = "售價：$\(viewModel.price)"
        self.viewModel?.onImageDownloaded = { [weak self] image in
            DispatchQueue.main.async {
                self?.icon.image = image
            }
        }
        self.viewModel?.getImage()
    }

}
