//
//  HeroTableViewCell.swift
//  API_Marvel
//
//  Created by Josimar  Fiuza Melo on 02/12/18.
//  Copyright © 2018 Josimar Fiuza Melo. All rights reserved.
//

import UIKit
import Kingfisher

class HeroTableViewCell: UITableViewCell {

    @IBOutlet weak var ivThumb: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func prepareCell(with hero: Hero) {
        lbName.text = hero.name
        lbDescription.text = hero.description
        
        if let url = URL(string: hero.thumbnail.url){
            ivThumb.kf.indicatorType = .activity
            ivThumb.kf.setImage(with: url)
        }else{
            ivThumb.image = nil
        }
        
        ivThumb.layer.cornerRadius = ivThumb.frame.height / 2
        ivThumb.layer.borderColor = UIColor.red.cgColor
        ivThumb.layer.borderWidth = 2
        
    }
}