//
//  PlaceListTableCell.swift
//  Weather
//
//  Created by Jithin on 9/1/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

import UIKit

class PlaceListTableCell: UITableViewCell {

    
    // MARK:- IBOutlet declaration
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
