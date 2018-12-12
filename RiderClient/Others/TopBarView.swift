//
//  TopBarView.swift
//  RiderClient
//
//  Created by Zo Asmail on 12/11/18.
//  Copyright © 2018 CreativityKills Co. All rights reserved.
//

import UIKit

class TopBarView: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(UIColor.gray.cgColor)
        context?.setLineWidth(2)
        context?.move(to: CGPoint(x: 0, y: bounds.height))
        context?.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
        context?.strokePath()
    }
}
