//
//  MTextField.swift
//  MetaID_real
//
//  Created by hanjinsik on 13/02/2019.
//  Copyright © 2019 metadium. All rights reserved.
//

import Foundation

class MTextField: UITextField {
    
    // MARK: Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Methods
    
    override func deleteBackward() {
        super.deleteBackward()
        
        print("deleteBackward")
    }
}

