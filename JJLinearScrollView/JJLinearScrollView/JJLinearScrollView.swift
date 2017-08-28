//
//  JJLinearScrollView.swift
//  JJLinearScrollView
//
//  Created by  HanJinJun on 2017/8/26.
//  Copyright © 2017年  HanJinJun. All rights reserved.
//

import UIKit
import SnapKit

/// 滚动方向
///
/// - vertical: 垂直方向
/// - horizontal: 水平方向
enum JJLinearScrollOrientation {
    /// 垂直方向
    case vertical
    /// 水平方向
    case horizontal
}

struct JJLinearSubView {
    var view:UIView
    var insets:UIEdgeInsets
    var height:CGFloat
}

class JJLinearScrollView: UIScrollView {

    /// 滚动方向
    @IBInspectable open var orientation:JJLinearScrollOrientation = .vertical
        {
            didSet {
                self.setNeedsUpdateConstraints()
            }
    }
    /// 内边距
    var inset = UIEdgeInsets.zero {
        didSet {
            self.contentView.snp.updateConstraints { (make) in
                make.edges.equalTo(self).inset(inset)
            }
        }
    }
    /// 各个控件的间距
    @IBInspectable var spacing:CGFloat = 0.0
    /// 子控件
    fileprivate var arrangedSubviews = Array<JJLinearSubView>()
    
    /// 内容视图
    lazy var contentView = UIView()
    
    // MARK: 初始化
    init(frame: CGRect, orientation: JJLinearScrollOrientation) {
        super.init(frame: frame)
        self.orientation = orientation
        self.setupUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    convenience init(orientation: JJLinearScrollOrientation) {
        self.init(frame: CGRect.zero, orientation: orientation)
    }
    
    convenience init() {
        self.init(frame: CGRect.zero, orientation: .vertical)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// MARK: 初始化UI
    func setupUI() {
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        
        // 设置内容视图布局
        self.addSubview(self.contentView);
    }
    
    /// 添加子控件，线性布局
    ///
    /// - Parameter view: 子控件
    override func addSubview(_ view: UIView) {
        self.addArrangedSubview(view, insets: UIEdgeInsets.zero, height: 0)
    }
    
    /// 添加子控件，线性布局
    ///
    /// - Parameters:
    ///   - view: 子控件
    ///   - insets: 子控件的边距
    ///   - height: 子控件的高度，不传默认自动高度
    func addArrangedSubview(_ view: UIView, insets:UIEdgeInsets = UIEdgeInsets.zero, height:CGFloat = 0.0) {
        if view == self.contentView {
            super.addSubview(view)
            return
        }
        self.contentView.addSubview(view)
        let subView = JJLinearSubView(view: view, insets: insets, height: height)
        self.arrangedSubviews.append(subView)
    }
    
    
    // MARK: 布局子控件
    private func layoutSubview(_ subView: JJLinearSubView, preSubView: JJLinearSubView?) {
        switch self.orientation {
        case .vertical:
            self.layoutVerticalSubview(subView, preSubView: preSubView)
            break
        case .horizontal:
            self.layoutHorizontalSubview(subView, preSubView: preSubView)
            break
        }
    }
    
    private func layoutVerticalSubview(_ subView: JJLinearSubView, preSubView: JJLinearSubView?) {
        subView.view.snp.remakeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(subView.insets.left)
            make.top.greaterThanOrEqualTo(self.contentView).offset(subView.insets.top)
            make.right.equalTo(self.contentView).offset(-subView.insets.right)
            make.bottom.lessThanOrEqualTo(self.contentView).offset(-subView.insets.bottom)
            
            if preSubView != nil {
                make.top.equalTo(preSubView!.view.snp.bottom).offset(subView.insets.top + preSubView!.insets.bottom)
            }
            if subView.height > 0 {
                make.height.equalTo(subView.height)
            }
        }
    }
    
    private func layoutHorizontalSubview(_ subView: JJLinearSubView, preSubView: JJLinearSubView?) {
        subView.view.snp.remakeConstraints { (make) in
            make.left.greaterThanOrEqualTo(self.contentView).offset(subView.insets.left)
            make.top.equalTo(self.contentView).offset(subView.insets.top)
            make.right.lessThanOrEqualTo(self.contentView).offset(-subView.insets.right)
            make.bottom.equalTo(self.contentView).offset(-subView.insets.bottom)
            
            if preSubView != nil {
                make.left.equalTo(preSubView!.view.snp.right).offset(subView.insets.left + preSubView!.insets.right)
            }
            if subView.height > 0 {
                make.width.equalTo(subView.height)
            }
        }
    }
    
    // MARK: 更新布局约束
    override func updateConstraints() {
        self.contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self).inset(self.inset)
            
            if self.orientation == .vertical {
                make.width.equalTo(self)
            } else {
                make.height.equalTo(self)
            }
        }
        
        var lastSubView:JJLinearSubView?
        for subView in self.arrangedSubviews {
            self.layoutSubview(subView, preSubView: lastSubView)
            lastSubView = subView
        }
        super.updateConstraints()
    }
}
