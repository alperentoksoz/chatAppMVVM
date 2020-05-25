//
//  InputContainerView.swift
//  ChatApp
//
//  Created by Alperen Toksöz on 25.05.2020.
//  Copyright © 2020 Alperen Toksöz. All rights reserved.
//

import UIKit

class InputContainerView: UIView {
    
    init(image: UIImage, textField: UITextField) {
        super.init(frame: .zero)
        setHeight(height: 50)
        
        let iv = UIImageView()
        iv.image = image
        iv.tintColor = .white

        addSubview(iv)
        iv.centerY(inView: self)
        iv.anchor(left: leftAnchor,paddingLeft: 8)
        iv.setDimensions(width: 20, height: 24)
        
        addSubview(textField)
        textField.centerY(inView: self)
            textField.anchor(left:iv.rightAnchor,bottom: bottomAnchor,right: rightAnchor,paddingLeft: 8,paddingBottom: -8)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        addSubview(dividerView)
        dividerView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 8, paddingRight: 8,height: 0.7)
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
