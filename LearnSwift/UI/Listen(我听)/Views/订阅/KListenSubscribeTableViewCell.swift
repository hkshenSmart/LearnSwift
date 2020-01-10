//
//  KListenSubscribeTableViewCell.swift
//  LearnSwift
//
//  Created by hkshen on 2020/1/10.
//  Copyright © 2020 hkshen. All rights reserved.
//

import UIKit

class KListenSubscribeTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - 懒加载
    // 背景大图
    private var picView : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 3
        return imageView
    }()
    
    // 标题
    private var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "---"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    // 副标题
    private var subLabel : UILabel = {
        let label = UILabel()
        label.text = "---"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    // 时间
    private var timeLabel : UILabel = {
        let label = UILabel()
        label.text = "2010年1月8日"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    // 播放按钮
    private var setBtn: UIButton = {
        let btn = UIButton.init(type: UIButton.ButtonType.custom)
        btn.isHidden = true
        btn.setTitle("播放", for: UIControl.State.normal)
        btn.setTitleColor(UIColor.gray, for: UIControl.State.normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return btn
    }()
    
    // MARK: - 初始化
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpLayout() {
        self.addSubview(self.picView)
        self.picView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(SizeFloat(x: 20))
            make.top.equalToSuperview().offset(SizeFloat(x: 15))
            make.bottom.equalToSuperview().offset(SizeFloat(x: -15))
            make.width.equalTo(SizeFloat(x: 70))
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.picView)
            make.left.equalTo(self.picView.snp.right).offset(SizeFloat(x: 10))
            make.height.equalTo(SizeFloat(x: 20))
            make.right.equalToSuperview()
        }
        
        self.addSubview(self.subLabel)
        self.subLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(SizeFloat(x: 5))
            make.left.height.right.equalTo(self.titleLabel)
        }
        
        self.addSubview(self.timeLabel)
        self.timeLabel.snp.makeConstraints { (make) in
            make.left.height.right.equalTo(self.titleLabel)
            make.bottom.equalTo(self.picView)
        }
        
        self.addSubview(self.setBtn)
        self.setBtn.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview().offset(SizeFloat(x: -20))
            make.width.equalTo(SizeFloat(x: 50))
            make.height.equalTo(SizeFloat(x: 30))
        }
    }
    
    // MARK: - 填充数据
    // 设置cmodel的时候执行
    var cmodel: KGuessYouLikeModel? {
        didSet {
            guard let model = cmodel else { return }
            
            self.titleLabel.text = model.title
            self.picView.kf.setImage(with: URL(string: model.coverMiddle!))
            self.subLabel.text = model.recReason
            self.timeLabel.text = model.lastUptrackAt.description
        }
    }
    
    // MARK: - 方法
    // 根据后台时间戳返回几分钟前 几小时前 几天前 或一个日期
    func updateTimeToCurrennTime(timeStamp: Double) -> String {
        // 获取当前的时间戳
        let currentTime = Date().timeIntervalSince1970
        // 时间戳为毫秒级要／1000  秒就不用除1000 参数带没带000
        let timeSta: TimeInterval = TimeInterval(timeStamp / 1000)
        // 时间差
        let reduceTime: TimeInterval = currentTime - timeSta
        // 时间差小于60秒
        if reduceTime < 60 {
            return "刚刚"
        }
        // 时间差大于一分钟小于60分钟内
        let mins = Int(reduceTime / 60)
        if mins < 60 {
            return "\(mins)分钟前"
        }
        let hours = Int(reduceTime / 3600)
        if hours < 24 {
            return "\(hours)小时前"
        }
        let days = Int(reduceTime / 3600 / 24)
        if days < 30 {
            return "\(days)天前"
        }
        // 不满足上述条件 或者是未来日期 则直接返回日期
        let date = NSDate(timeIntervalSince1970: timeSta)
        let dfmatter = DateFormatter()
        // yyyy-MM-dd HH:mm:ss
        dfmatter.dateFormat="yyyy年MM月dd日 HH:mm:ss"
        return dfmatter.string(from: date as Date)
    }
}
