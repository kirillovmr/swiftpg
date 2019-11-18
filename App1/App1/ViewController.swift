//
//  ViewController.swift
//  App1
//
//  Created by Viktor Kirillov on 11/15/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//    @IBOutlet var coolview : UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        Bundle.main.loadNibNamed("View", owner: self)
//        self.view.addSubview(self.coolview)
    }
    
    var n:Int = 0
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.backgroundColor = n % 2 == 0 ? .yellow : .white;
        n += 1
    }
    
    @IBAction func ButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Hey", message: "You tapped me.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        self.present(alert, animated: true)
    }
    
}

