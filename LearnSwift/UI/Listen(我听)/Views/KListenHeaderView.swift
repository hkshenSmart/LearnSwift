//
//  KListenHeaderView.swift
//  LearnSwift
//
//  Created by hkshen on 2020/1/9.
//  Copyright © 2020 hkshen. All rights reserved.
//

import UIKit
import SnapKit

// 用代理回调 和OC里的代理差不多
protocol KListenHeaderViewDelegate: NSObjectProtocol {
    
    // 点击了下载 历史 已购 喜欢 回调
    func doSelectedAtIndex(index: Int)
}

class KListenHeaderView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // 和OC写代理属性差不多
    weak var delegate: KListenHeaderViewDelegate?
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 布局
    func layoutUI() {
        let bView = UIView()
        bView.backgroundColor = LBFMDownColor
        self.addSubview(bView)
        bView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(SizeFloat(x: 10))
        }
        
        // 直接循环布局 当然也可以用UICollectionView布局
        let margin: CGFloat = Screen_Width / 8
        let titleArray = ["下载", "历史", "已购", "喜欢"]
        let imageArray = ["下载", "历史", "购物车", "喜欢"]
        let numArray = ["暂无", "8", "暂无", "25"]
        // ..< 不包含最大值的区间 ...包含最大值和最小值的区间
        for index in 0..<4 {
            let button = UIButton.init(frame: CGRect(x: margin * CGFloat(index) * 2 + margin / 2, y: SizeFloat(x: 10), width: margin, height: margin))
            button.setImage(UIImage(named: imageArray[index]), for: UIControl.State.normal)
            self.addSubview(button)
            
            let titleLabel = UILabel()
            titleLabel.textAlignment = .center
            titleLabel.text = titleArray[index]
            titleLabel.font = UIFont.systemFont(ofSize: 15)
            titleLabel.textColor = UIColor.gray
            self.addSubview(titleLabel)
            titleLabel.snp.makeConstraints({ (make) in
                make.centerX.equalTo(button)
                make.width.equalTo(margin + 20)
                make.top.equalTo(margin + SizeFloat(x: 10))
            })
            
            let numLabel = UILabel()
            numLabel.textAlignment = .center
            numLabel.text = numArray[index]
            numLabel.font = UIFont.systemFont(ofSize: 14)
            numLabel.textColor = UIColor.gray
            self.addSubview(numLabel)
            numLabel.snp.makeConstraints({ (make) in
                make.centerX.equalTo(button)
                make.width.equalTo(margin + 20)
                make.top.equalTo(margin + SizeFloat(x: 10) + SizeFloat(x: 25))
            })
            button.tag = index
            button.addTarget(self, action: #selector(tapBtn(sender:)), for: UIControl.Event.touchUpInside)
        }
    }
    
    // MARK: - 按钮方法
    @objc func tapBtn(sender: UIButton) {
        self.delegate?.doSelectedAtIndex(index: sender.tag)
    }
}
