//
//  Slider.swift
//  Pods
//
//  Created by 王小涛 on 2016/12/20.
//
//

import Foundation

public class Slider: UIView {
    
    public var sliderBackgroundColor: UIColor? {
        didSet {
            slider.backgroundColor = sliderBackgroundColor
        }
    }
    
    private let slider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1.0, green: 0.4, blue: 0.6, alpha: 1)
        return view
    }()
    
    public convenience init(isSelected: Bool) {
        self.init()
        addSubview(slider)
        slider.isHidden = !isSelected
    }
    
    public override var frame: CGRect {
        didSet {
            super.frame = frame
            self.slider.frame = CGRect(x: 0, y: self.bounds.height - 2, width: self.bounds.width, height: 2)
        }
    }
}
