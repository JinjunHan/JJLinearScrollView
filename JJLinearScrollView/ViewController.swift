//
//  ViewController.swift
//  JJLinearScrollView
//
//  Created by  HanJinJun on 2017/8/26.
//  Copyright © 2017年  HanJinJun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let scrollView = JJLinearScrollView(frame: CGRect(x: 0, y: 20, width: self.view.bounds.size.width, height: self.view.bounds.size.width), orientation: .vertical)
        let btn1 = UIButton(type: .system);
        btn1.setTitle("button1", for: .normal)
        scrollView.addArrangedSubview(btn1, insets: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 20))
        
        let label1 = UILabel()
        label1.text = "label2"
        scrollView.addArrangedSubview(label1, height: 80)
        self.view.addSubview(scrollView)
        
        let label2 = UILabel()
        label2.text = "label222label222label222label222label222label222"
        label2.numberOfLines = 0
        scrollView.addSubview(label2)
        self.view.addSubview(scrollView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

