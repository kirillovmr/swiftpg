//
//  RedBButton.swift
//  App1
//
//  Created by Viktor Kirillov on 11/16/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import UIKit

class RedBButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .red
    }
    
    @IBInspectable var borderWidthzalupa : CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }

}
