//
//  ItemCell.swift
//  ecommerce
//
//  Created by Guy Daher on 03/02/2017.
//  Copyright © 2017 Guy Daher. All rights reserved.
//

import UIKit
import AFNetworking
//import Cosmos

class ItemCell: UITableViewCell {
    
//    @IBOutlet weak var itemImageView: UIImageView!
//    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var priceLabel: UILabel!
//    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    //    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var fireLabel: UILabel?
    
    static let placeholder = UIImage(named: "placeholder")
    
    var item: ItemRecord? {
        didSet {
            guard let item = item else { return }

            nameLabel.highlightedText = item.name_highlighted
            nameLabel.highlightedTextColor = UIColor.black
            nameLabel.highlightedBackgroundColor = ColorConstants.lightYellowColor
            typeLabel.highlightedText = item.type_highlighted
            typeLabel.highlightedTextColor = UIColor.black
            typeLabel.highlightedBackgroundColor = ColorConstants.lightYellowColor
            
            let fire:String? = item.fire
            if fire != nil{
                fireLabel?.highlightedText = fire!
//                nameLabel.highlightedText = fire!
            }
            

            if let price = item.price {
                priceLabel.text = "$\(String(describing: price))"
            }

//            ratingView.settings.updateOnTouch = false
//            if let rating = item.rating {
//                ratingView.rating = Double(rating)
//            }

//            itemImageView.cancelImageDownloadTask()
            if let url = item.imageUrl {
                
                itemImageView.contentMode = .scaleAspectFit
                itemImageView.setImageWith(url, placeholderImage: ItemCell.placeholder)
            } else {
                itemImageView.image = ItemCell.placeholder
            }
        }
    }
}
//
//  ItemCell.swift
//  RiderClient
//
//  Created by Zo Asmail on 12/11/18.
//  Copyright © 2018 CreativityKills Co. All rights reserved.
//

import Foundation
