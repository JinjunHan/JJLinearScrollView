//
//  ViewController.swift
//  JJLinearScrollView
//
//  Created by  HanJinJun on 2017/8/26.
//  Copyright © 2017年  HanJinJun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var scrollView:JJLinearScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let addButton = UIButton(type: .system)
        addButton.setTitle("添加", for: .normal)
        addButton.addTarget(self, action: #selector(addClicked), for: .touchUpInside)
        self.view.addSubview(addButton)
        addButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.snp.bottom).offset(-50)
            make.centerX.equalTo(self.view)
        }
        
        let scrollView = JJLinearScrollView(orientation: .vertical)
        self.scrollView = scrollView
        scrollView.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(20)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(addButton.snp.top).offset(-10);
        }
        
        let btn1 = UIButton(type: .system);
        btn1.setTitle("自动高度，top:5,left:10,bottom:10,right:20", for: .normal)
        btn1.backgroundColor = self.randomColor()
        scrollView.addArrangedSubview(btn1, insets: UIEdgeInsets(top: 5, left: 10, bottom: 10, right: 20))
        
        let label1 = UILabel()
        label1.text = "高度80"
        label1.backgroundColor = self.randomColor()
        scrollView.addArrangedSubview(label1, height: 80)
        self.view.addSubview(scrollView)
        
        let label2 = UILabel()
        label2.text = "label222label222label222label222label222label222label222label222label222label222label222label\n222label222label222label222label222label222label222label222label222label222label222label222label222label222label222label222label222label222label222"
        label2.numberOfLines = 0
        label2.backgroundColor = self.randomColor()
        scrollView.addSubview(label2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func addClicked() -> Void {
        let view = UILabel()
        view.textAlignment = .center
        view.backgroundColor = self.randomColor()
        let height = CGFloat(arc4random()%100+50)
        view.text = "高度:\(height)"
        self.scrollView.addArrangedSubview(view, insets: UIEdgeInsets.zero, height: height)
    }
    
    func randomColor() -> UIColor {
        let red = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue = CGFloat(arc4random()%256)/255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

