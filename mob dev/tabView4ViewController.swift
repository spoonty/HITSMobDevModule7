//
//  tabView4ViewController.swift
//  mob dev
//
//  Created by spoonty on 5/16/21.
//  Copyright © 2021 Пользователь. All rights reserved.
//

import UIKit

class tabView4ViewController: UIViewController {

    
    @IBOutlet weak var img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        img.image = picture
    }

}
