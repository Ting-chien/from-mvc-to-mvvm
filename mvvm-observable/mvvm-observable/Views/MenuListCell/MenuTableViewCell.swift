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
        self.viewModel?.clearOnReuse()
    }
    
    func setup(viewModel: MenuCellViewModel) {
        
        self.viewModel = viewModel
        
        viewModel.events.onNameChanged.bind { [weak self] value in
            DispatchQueue.main.async {
                self?.name.text = value
            }
        }
        
        viewModel.events.onPriceChanged.bind { [weak self] value in
            DispatchQueue.main.async {
                self?.price.text = value
            }
        }
        
        viewModel.events.onImageDownloaded.bind { [weak self] value in
            DispatchQueue.main.async {
                self?.icon.image = value
            }
        }
        
    }

}
