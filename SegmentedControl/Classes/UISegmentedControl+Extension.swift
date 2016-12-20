//
//  UISegmentedControl+Extension.swift
//  Pods
//
//  Created by 王小涛 on 2016/12/20.
//
//

import Foundation

public extension UISegmentedControl {
    
    var segmentSpacing: CGFloat {
        get {
            let image = dividerImage(forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
            return image?.size.width ?? 1.0
        }
        set {
            if newValue > 0 {
                let image = UIImage.fromColor(.clear, withSize: CGSize(width: newValue, height: 1))!
                setDividerImage(image, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
            }else {
                setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
            }
        }
    }
    
    var items: [String] {
        get {
            return (0..<numberOfSegments).flatMap(titleForSegment)
        }
        set {
            removeAllSegments()
            newValue.forEach { insertSegment(withTitle: $0, at: $1, animated: true) }
        }
    }
    
    var itemWidths: [CGFloat] {
        get {
            return (0..<numberOfSegments).map(widthForSegment)
        }
        set {
            newValue.forEach(setWidth)
        }
    }
    
    var contentLength: CGFloat {
        return (0..<numberOfSegments).reduce(0) { $0 + widthForSegment(at: $1) } + CGFloat((numberOfSegments - 1)) * segmentSpacing
    }
    
    func contentOffsetForSegment(at index: Int) -> CGPoint {
        return CGPoint(x: (0..<index).reduce(0) { $0 + widthForSegment(at: $1) } + CGFloat(index) * segmentSpacing,
                       y: 0)
    }
}

