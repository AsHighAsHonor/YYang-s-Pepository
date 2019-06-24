//
//  LevelDropFooter.swift
//  
//
//  Created by YYang1 on 12/11/18.
//  
//

import UIKit

class LevelDropFooter: UIView, NibLoadable {
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        warningLabel.textColor = .black
        warningLabel.font = FONT_14
    
        saveButton.set(font: FONT_14, textColor: .white, backgroundColor: .black, text: "SAVE", state: .normal)
        
    }

}
