//
//  DetailViewController.swift
//  mvvm-closure
//
//  Created by Ting-Chien Wang on 2021/3/31.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var itemImageVIew: UIImageView!
    
    let viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
