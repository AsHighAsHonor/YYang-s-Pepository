    //
    //  FaceView.swift
    //  Views
    //
    //  Created by YYang on 22/01/2017.
    //  Copyright © 2017 YYang. All rights reserved.
    //

    import UIKit

    @IBDesignable
    class FaceView: UIView {

 //使用@IBInspectable 标示的变量必须显示声明类型 否则 IB 无法自动推断
    @IBInspectable
        var faceColor : UIColor = UIColor.red{
        //didSet 用于观察属性值的变化
        didSet{ //全局变量想要在其他类的代码中修改时候需要调用 draw 方法,时候用setNeedsDisplay 来标记更改需要重绘界面
                setNeedsDisplay()
            }
        }
    @IBInspectable
        var isSmile :Bool = true{didSet{setNeedsDisplay()}}
    @IBInspectable
    var lineWidth : CGFloat = 5

    
   private var eyeScale :CGFloat = 0.1

   private var faceWidth : CGFloat{
        return bounds.size.width
    }
        
    
   private  var faceHeight : CGFloat{
        return bounds.size.height
    }




    private var faceCenter : CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY )
    }

    private var leftEyeCenter : CGPoint {
        return CGPoint(x: bounds.midX - bounds.size.width*0.2, y: bounds.midY - bounds.size.height*0.1)
    }

    private var rightEyeCenter : CGPoint {
        return CGPoint(x: bounds.midX + bounds.size.width*0.2, y: bounds.midY - bounds.size.height*0.1)
    }



    private var radius : CGFloat{
        return min(bounds.size.width, bounds.size.height) / 2
    }


    private struct CyclePathInfo {
        var arcCenter :CGPoint?
        var radius : CGFloat?
        var angleScale : CGFloat?
    }

    struct CurveInfo {
        static let  mouthXOffsetScale : CGFloat = 0.4
        static let  mouthYOffsetScale : CGFloat = 1.4
        static let browLargeOffsetScale : CGFloat = 0.7
        static let browSmallOffsetScale : CGFloat = 0.3
        static let browYOffsetScale : CGFloat = 0.5
        
    }

    private enum Eyes {
        case left
        case right
    }




    private  func drawCycle(withCyclePathInfo pathInfo:CyclePathInfo) {
        
        faceColor.set()
        //        let facePath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)) //内切圆
        let facePath = UIBezierPath(
            arcCenter: pathInfo.arcCenter!,
            radius:pathInfo.radius!,
            startAngle: 0,
            endAngle: CGFloat( 2 * M_PI)  * pathInfo.angleScale!,
            clockwise:true
        )
        
        facePath.lineWidth = lineWidth //线条宽度
        //        facePath.lineCapStyle = CGLineCap.square
        facePath.stroke()//画线

        //        UIColor.blue.set()
    //        UIColor.red.setStroke()
    //        UIColor.red.setFill()

        //        facePath.fill()
    }

    private func drawCurve(withStartPoint startPoint : CGPoint ,andEndPoint endPoint : CGPoint ,andControlPoint controlPoint: CGPoint ) -> () {
        
        faceColor.set()
        
        let curvePath = UIBezierPath()
        curvePath.move(to: startPoint)
        curvePath.addQuadCurve(to: endPoint, controlPoint: controlPoint)
        curvePath.lineWidth = lineWidth
        curvePath.stroke()
        
    }

    private   func drawMouth(smile:Bool) -> () {
        
        let start  = CGPoint(x: faceCenter.x * CurveInfo.mouthXOffsetScale , y : faceCenter.y * CurveInfo.mouthYOffsetScale)
        let end  = CGPoint(x: faceWidth - start.x , y :  faceCenter.y * CurveInfo.mouthYOffsetScale)
        var  ctrl  = CGPoint(x:0,y:0)
        
        if smile {
            ctrl = CGPoint(x: faceCenter.x ,y:  2 * start.y - faceCenter.y)
        }else{
            ctrl = CGPoint(x: faceCenter.x ,y: faceCenter.y)
        }
        drawCurve(withStartPoint: start, andEndPoint: end, andControlPoint: ctrl)

    }


        private func drawBrow(withbrowAspect browAspect : Eyes) -> () {
        
        let yPositon =  rightEyeCenter.y*CurveInfo.browLargeOffsetScale
        var start  = CGPoint(x:0 , y : 0)
        var end  = CGPoint(x: 0 , y :  0)
        var  ctrl  = CGPoint(x : 0 , y : 0)
        
        switch browAspect {
        case .left:
             start  = CGPoint(x: faceCenter.x - faceCenter.x * CurveInfo.browLargeOffsetScale , y : yPositon)
             end  = CGPoint(x: faceCenter.x - faceCenter.x * CurveInfo.browSmallOffsetScale , y :  yPositon)

            ctrl = CGPoint(x:leftEyeCenter.x , y : start.y * 0.5)

        case .right:
            start  = CGPoint(x: faceCenter.x + faceCenter.x * CurveInfo.browLargeOffsetScale , y : yPositon)
            end  = CGPoint(x: faceCenter.x + faceCenter.x * CurveInfo.browSmallOffsetScale , y :  yPositon)
            
            ctrl = CGPoint(x: rightEyeCenter.x , y : start.y * 0.5)
        }
        
        drawCurve(withStartPoint: start, andEndPoint: end, andControlPoint: ctrl)

    }




    override func draw(_ rect: CGRect) {
        
        //脸
        drawCycle(withCyclePathInfo: CyclePathInfo(arcCenter: faceCenter, radius: radius,angleScale: 1))
            
        
    //        //嘴巴
        drawMouth(smile: isSmile)
    //
    //        //左眼
        drawCycle(withCyclePathInfo: CyclePathInfo(arcCenter: leftEyeCenter, radius: radius * eyeScale, angleScale: 1))

    //        //右眼
        drawCycle(withCyclePathInfo: CyclePathInfo(arcCenter: rightEyeCenter, radius: radius * eyeScale, angleScale: 1))

        drawBrow(withbrowAspect: .left)
        
        drawBrow(withbrowAspect: .right)
        
        
        
    }

    }
