//
//  KAlldefine.swift
//  LearnSwift
//
//  Created by hkshen on 2020/1/9.
//  Copyright © 2020 hkshen. All rights reserved.
//

import UIKit
import Foundation

var StatusHeight: CGFloat?
var NavHeight: CGFloat?
var TabBarHeight: CGFloat?

// Swift中是不能使用宏定义语法的，但是因为命名空间的缘故，我们可以给我们的项目添加一个空的xxx.swift文件
// 在这xxx.swift中，我们将原本OC中不需要接受参数的宏，定义成let常量
// 在这xxx.swift中，将需要接受参数的宏定义成函数即可

//#define Screen_Width [UIScreen mainScreen].bounds.size.width
//#define Screen_Height [UIScreen mainScreen].bounds.size.height
let Screen_Width = UIScreen.main.bounds.size.width
let Screen_Height = UIScreen.main.bounds.size.height

let LBFMButtonColor = UIColor(red: 242/255.0, green: 77/255.0, blue: 51/255.0, alpha: 1)
let LBFMDownColor = UIColor.init(red: 240/255.0, green: 241/255.0, blue: 244/255.0, alpha: 1)

// iphone X
let isIphoneX = Screen_Width == 812 ? true : false
// LBFMNavBarHeight
let LBFMNavBarHeight : CGFloat = isIphoneX ? 88 : 64
// LBFMTabBarHeight
let LBFMTabBarHeight : CGFloat = isIphoneX ? 49 + 34 : 49


// OC写法
//#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
// Swift写法
func RGBCOLOR(r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: 1.0)
}

// 适配等比放大控件
//#define SizeFloat(x)                   ((x) * Screen_Width * 1.0 / 375.0)
func SizeFloat(x: CGFloat) -> CGFloat {
    return ((x) * Screen_Width * 1.0 / 375.0)
}
