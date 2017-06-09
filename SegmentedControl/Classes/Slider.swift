//
//  Slider.swift
//  Pods
//
//  Created by 王小涛 on 2016/12/20.
//
//

import Foundation

public class Slider: UIView {
    
    private let slider = UIView()
    private var siiderHeight: CGFloat = 2
    
    public convenience init(isSelected: Bool, color: UIColor = UIColor(red: 1.0, green: 0.4, blue: 0.6, alpha: 1), height: CGFloat = 2) {
        self.init()
        addSubview(slider)
        slider.backgroundColor = color
        siiderHeight = height
        slider.isHidden = !isSelected
    }
    
    public override var frame: CGRect {
        didSet {
            super.frame = frame
            self.slider.frame = CGRect(x: 0, y: self.bounds.height - siiderHeight, width: self.bounds.width, height: siiderHeight)
        }
    }
}
