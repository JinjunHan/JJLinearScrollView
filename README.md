# JJLinearScrollView

基于UIScrollView的可滑动线性布局，快速简便地实现线性自动布局。布局基于autolayout,引用了SnapKit第三方库。

## 准备 
* 下载代码,拖入JJLinearScrollView.swift
* 若之前无使用SnapKit，请先引用[SnapKit](https://github.com/SnapKit/SnapKit)

## 开始使用

十分简单，只需初始化，然后addSubView就可以了
```
let scrollView = JJLinearScrollView(frame: frame)
let subView = UIView()
scrollView.addSubview(subView)
```

另外也可以添加时还可以设置边距和高度,高度为0或不传高度，那么高度由子控件自己控制，基于autolayout
```
scrollView.addArrangedSubview(view, insets: UIEdgeInsets.zero)
scrollView.addArrangedSubview(view, insets: UIEdgeInsets.zero, height: 0)
```

### 线性布局方向
可以在初始化的时候设置或者初始化之后切换也可以,默认是垂直方向
```
JJLinearScrollView(.vertical)
JJLinearScrollView(.horizontal)
scrollView.orientation = .horizontal
``` 

### 其他设置
* inset 全部子控件距离父控件的边距
* spacing 全部子控件之间的间隔
