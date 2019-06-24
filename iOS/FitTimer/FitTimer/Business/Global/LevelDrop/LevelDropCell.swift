//
//  LevelDropCell.swift
//  
//
//  Created by YYang1 on 12/11/18.
//  
//

import UIKit

class LevelDropCell: UITableViewCell, NibLoadable {
    @IBOutlet weak var checkMarkLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        checkMarkLabel.textColor = .gray
        checkMarkLabel.font = UIFont(name: FONTAWESOME, size: 25)
        checkMarkLabel.text = ICON_UNCHECKED

        levelLabel.textColor = .black
        levelLabel.font = FONT_16
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        checkMarkLabel.text = selected  ? ICON_CHECKED : ICON_UNCHECKED
//        checkMarkLabel.textColor = selected  ? THE_BOD_TEXT_BLACK : THE_BOD_GRAY
//    }
    
}
