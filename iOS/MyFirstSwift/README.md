#《Developing iOS 9 Apps with Swift》 - Calculator Demo

> swift 的学习一开始花三天时间大致浏览了一遍 《The Swift Programming Language (Swift3.0.1) 》和  《Using Swift with Cocoa and Objective-C (Swift 3.0.1) 》,前者主要是swift 语言本身的语法详解,后者则是介绍了在 Cocoa下使用 swift 新特性编程以及 swift 与 OC的对比 . 大致浏览一遍 swift 语法后就可以看《Using Swift with Cocoa and Objective-C (Swift 3.0.1) 》如果有 OC 经验的就能更加直观的理解 swift 新特性的使用场景,如果遇到不清楚的语法再去翻看语法书, 这样理解效果会好很多.   

> 下载链接 :


  [《The Swift Programming Language (Swift3.0.1) 》](https://itun.es/au/jEUH0.l) 
  
[《Using Swift with Cocoa and Objective-C (Swift 3.0.1) 》](https://itun.es/au/1u3-0.l).




> 公开课里质量很高的 swift 教学视频是 Stanford University 系列 , 这篇文章就是在看完 《Developing iOS 9 Apps with Swift》前两堂课后写的, 教程通过一个计算器的小 demo 对 swift 基础做了介绍 ,功能并不复杂但囊括了 enum , struct , class , optional type 等 swift新特性 , 以及 MVC 思想的介绍实践 , 并且Paul 对每个知识点都给出了通俗易懂的解释,墙裂推荐视频多看几遍 , 一些细节的处理有助于提高代码的质量 , 同时 E 文的字幕也是程序猿不错的英语练习材料 .  
> 看完视频后仿照教程完成了一个简单的计算器,以下是一些写 demo 过程中对 swift 特性的理解 , 才疏学浅记下来 , 望大神指出理解有误的地方.


-------
##Demo 介绍
![2017-01-18 at 00.43](https://github.com/AsHighAsHonor/YYangs-Pepository/blob/master/Image/2017-01-18%20at%2000.43.gif)
>先介绍一下demo,新建的 swift 工程 , 在教程的基础上仿照系统的计算器实现了简单的四则运算 ,点击数字键盘选择运算操作,键盘上方的区域显示计算结果,代码基本上和教程里相同 ; UI 使用 storyboard 通过StackView + autolayout 布局 . 
>
* `CalculatorBrain.swift` model 层 包含计算器所有的计算逻辑对外提供接口:
    1.  `internal func setOperand(operand: String)` 用于向 model 层传递用户点击计算器键盘的值
    2. `internal var result: String { get }` read-only computed property 用于返回计算的结果 string
    3. `mathematicalOperate`点击运算符后的调用的方法.

    
>* `ViewController.swift`controller 层  有两个**@IBAction** `performOperation`对应界面上所有的运算符号的点击事件.
>`numPadBtnClicked`对应界面上所有数字键盘的点击事件.

>Demo里有两个大的问题 
~~1.  没有实现系统那样的连续计算,需要每次运算点击" = "号 才能用上一次运算的结果进行下一次运算.~~(已修复)
2. 设备横屏会有约束问题 , 这可能和 StackView 有关,后续修复.

**最后附上下载地址:**

[《Developing iOS 9 Apps with Swift》](https://github.com/AsHighAsHonor/Developing-iOS-9-Apps-with-Swift)


[《CalculatorDemo》](https://github.com/AsHighAsHonor/YYangs-Pepository/tree/master/iOS/MyFirstSwift)

