//
//  SegmentedControl.swift
//  Pods
//
//  Created by 王小涛 on 2016/12/19.
//
//

import UIKit

public class SegmentedView: UIView {
    
    public static var animatedDuration: TimeInterval = 0.3
    
    fileprivate let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.alwaysBounceHorizontal = false
        view.alwaysBounceVertical = false
        view.isDirectionalLockEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        return view
    }()
    
    fileprivate let maskHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    fileprivate let segmentedControl: UISegmentedControl = {
        let view = UISegmentedControl()
        view.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red: 1.0, green: 0.4, blue: 0.6, alpha: 1)], for: .selected)
        view.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)], for: .normal)
        view.apportionsSegmentWidthsByContent = true
        return view
    }()
    
    public convenience init(items: [String]) {
        self.init(frame: .zero)
        items.forEach { segmentedControl.insertSegment(withTitle: $0, at: $1, animated: true) }
    }
    
    public override var tintColor: UIColor! {
        didSet {
            super.tintColor = tintColor
            segmentedControl.tintColor = .clear
        }
    }
    
    public var items: [String] = [] {
        didSet {
            segmentedControl.items = items
        }
    }
    
    public var itemWidths: [CGFloat] = [] {
        didSet {
            segmentedControl.itemWidths = itemWidths
        }
    }
    
    public var segmentSpacing: CGFloat = 0.0 {
        didSet {
            segmentedControl.segmentSpacing = segmentSpacing
        }
    }
    
    public var overlap: CGFloat = 0
    
    public var contentInset: UIEdgeInsets = .zero {
        didSet {
            scrollView.contentInset = contentInset
        }
    }
    
    public func setTitleTextAttributes(_ attributes: [AnyHashable : Any]?, for state: UIControlState) {
        segmentedControl.setTitleTextAttributes(attributes, for: state)
    }
    
    public var segmentBackgroundView: (_ selected: Bool) -> UIView = Slider.init
    
    fileprivate var selectedSegmentMaskView: UIView?
    
    public var selectedSegmentIndex: Int = 0 {
        
        didSet {
            
            let oldFrame = CGRect(x: segmentedControl.contentOffsetForSegment(at: oldValue).x, y: 0, width: segmentedControl.widthForSegment(at: oldValue), height: bounds.height)
            let newFrame = CGRect(x: segmentedControl.contentOffsetForSegment(at: selectedSegmentIndex).x, y: 0, width: segmentedControl.widthForSegment(at: selectedSegmentIndex), height: bounds.height)
                    
            UIView.animate(withDuration: SegmentedView.animatedDuration, animations: {
                self.selectedSegmentMaskView?.frame = newFrame
            }) { finished in
                print("finished = \(finished)")
            }
            
            let delta = segmentedControl.contentOffsetForSegment(at: selectedSegmentIndex).x - scrollView.contentOffset.x - overlap
            if delta < 0 {
                var contentOffset = scrollView.contentOffset
                contentOffset.x = max(-scrollView.contentInset.left, contentOffset.x + delta)
                // 往右滑动，contentOffset.x 变小
                scrollView.setContentOffset(contentOffset, animated: true)
            }else {
                
                let delta = (segmentedControl.contentOffsetForSegment(at: selectedSegmentIndex).x + segmentedControl.widthForSegment(at: selectedSegmentIndex)) - (scrollView.contentOffset.x + scrollView.bounds.width) + overlap
                if delta > 0 {
                    var contentOffset = scrollView.contentOffset
                    contentOffset.x = min(scrollView.contentSize.width + scrollView.contentInset.right - scrollView.bounds.width, contentOffset.x + delta)
                    // 往左滑动，contentOffset.x 变大
                    scrollView.setContentOffset(contentOffset, animated: true)
                }
            }
            
            segmentedControl.selectedSegmentIndex = selectedSegmentIndex
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        reload()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public func reload() {
        scrollView.frame = bounds
        segmentedControl.frame = CGRect(x: 0, y: 0, width: segmentedControl.contentLength, height: bounds.height)
        scrollView.contentSize = CGSize(width: max(segmentedControl.frame.width, bounds.width), height: bounds.height)
        maskHolderView.frame = segmentedControl.frame
        makeMaskViews()
    }
}

private extension SegmentedView {

    func setup() {
        addSubview(scrollView)
        scrollView.addSubview(maskHolderView)
        scrollView.addSubview(segmentedControl)
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(sender:)), for: .valueChanged)
    }
    
    func makeMaskViews() {
        
        maskHolderView.removeAllSubviews()
        
        (0..<segmentedControl.numberOfSegments).forEach {
            let frame = CGRect(x: segmentedControl.contentOffsetForSegment(at: $0).x, y: 0, width: segmentedControl.widthForSegment(at: $0), height: segmentedControl.bounds.height)
            
            let maskView = segmentBackgroundView(false)
            maskView.frame = frame
            maskHolderView.insertSubview(maskView, at: $0)
        }
        
        let frame = CGRect(x: segmentedControl.contentOffsetForSegment(at: selectedSegmentIndex).x, y: 0, width: segmentedControl.widthForSegment(at: selectedSegmentIndex), height: segmentedControl.bounds.height)
        let maskView = segmentBackgroundView(true)
        maskView.frame = frame
        selectedSegmentMaskView = maskView
        maskHolderView.addSubview(maskView)
        
        segmentedControl.selectedSegmentIndex = selectedSegmentIndex
    }
    
    @objc func segmentedControlValueChanged(sender: UISegmentedControl) {
        selectedSegmentIndex = sender.selectedSegmentIndex
    }
}

