//
//  ViewController.swift
//  SegmentControl
//
//  Created by wangxiaotao on 12/19/2016.
//  Copyright (c) 2016 wangxiaotao. All rights reserved.
//

import SegmentedControl

class ViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: SegmentedControl!
    @IBOutlet weak var testSegmentedControl: UISegmentedControl!

    private let items = ["最新1", "最新2", "最新3", "最新4", "最新5", "最新6", "最新7", "最新8", "最新9", "最新10"]

    override func viewDidLoad() {
        super.viewDidLoad()

        segmentedControl.items = items
        segmentedControl.itemWidths = [50,50,50,50,50,50,50,50,50,50]
        
        segmentedControl.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red: 1.0, green: 0.4, blue: 0.6, alpha: 1)], for: .selected)
        segmentedControl.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)], for: .normal)

        segmentedControl.segmentBackgroundView = Block.init
        segmentedControl.segmentSpacing = 10
        segmentedControl.overlap = 50
        segmentedControl.tintColor = .clear
        segmentedControl.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)

        segmentedControl.animated = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}



