//
//  DetailProfileCell.swift
//  test
//
//  Created by mhtran on 1/14/17.
//  Copyright © 2017 mhtran. All rights reserved.
//

import UIKit

class DetailProfileCell: UITableViewCell {

    @IBOutlet weak var nameDetail: UILabel!
    @IBOutlet weak var studyLabel: UILabel!
    @IBOutlet weak var lightLabel: UILabel!
    @IBOutlet weak var buttonMessage: UIButton!
    var callBack:(()->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        if let callBack = self.callBack {
            callBack()
        }
    }
}
