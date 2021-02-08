//
//  BezierPathPropertyViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/1/29.
//

import UIKit
import Highlightr

class BezierPathPropertyViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let highlightr = Highlightr()!
        let code = """
                    // 创建在rect内的矩形
                    * public convenience init(rect: CGRect)
                    *


                    * // 创建在rect里的内切曲线
                    * public convenience init(ovalIn rect: CGRect)
                    *


                    * // 创建带有圆角的矩形，当矩形变成正圆的时候，Radius就不再起作用: rect:矩形的Frame  cornerRadius:圆角大小
                    * public convenience init(roundedRect rect: CGRect, cornerRadius: CGFloat) // rounds all corners with the same horizontal and vertical radius
                    *


                    * // 设定特定的角为圆角的矩形 rect:矩形的Frame  corners:指定的圆角  cornerRadii:圆角的大小
                    * public convenience init(roundedRect rect: CGRect, byRoundingCorners corners: UIRectCorner, cornerRadii: CGSize)
                    *


                    * // 创建圆弧 center: 圆点  radius: 半径  startAngle: 起始位置  endAngle: 结束位置 clockwise: 是否顺时针
                    * public convenience init(arcCenter center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool)
                    *


                    * // 通过已有路径创建路径
                    * public convenience init(cgPath CGPath: CGPath)
                    *


                    * public init()
                    *


                    * public init?(coder: NSCoder)
                    *


                    * cgPath:   将UIBezierPath类转换成CGPath，类似于UIColor的CGColor
                    *
                    *


                    * // Path construction
                    *
                    * // 移动到某一点  point
                    * open func move(to point: CGPoint)
                    *


                    * // 绘制一条一条线    to->Point
                    * open func addLine(to point: CGPoint)
                    *


                    * // 创建三次贝塞尔线  ennPoint:终点  controlPoint1:控制点1 controlPoint2:控制点2
                    * open func addCurve(to endPoint: CGPoint, controlPoint1: CGPoint, controlPoint2: CGPoint)
                    *


                    * // 创建二次贝塞尔曲线  endPoint:终点   controlPoint:控制点
                    * open func addQuadCurve(to endPoint: CGPoint, controlPoint: CGPoint)
                    *


                    * // 添加圆弧  center: 圆点  radius: 半径  startAngle: 起始位置  endAngle: 结束位置 clockwise: 是否顺时针
                    * open func addArc(withCenter center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool)
                    *


                    * // 闭合路径，即在终点和起点连一根线
                    * open func close()
                    *


                    * // 清空路径
                    * open func removeAllPoints()
                    *


                    * // Appending paths
                    *
                    * // 追加路径 bezierPath: 追加的路径
                    * open func append(_ bezierPath: UIBezierPath)
                    *


                    * // Modified paths
                    *
                    * // 扭转路径，即起点变成终点，终点变成起点
                    * @available(iOS 6.0, *)
                    * open func reversing() -> UIBezierPath
                    *
                    *


                    * // Transforming paths
                    *
                    * // 路径进行仿射变换 transform:仿射变换
                    * open func apply(_ transform: CGAffineTransform)
                    *
                    *


                    * // Path info
                    *
                    * // 布尔值，指示路径是否具有任何有效元素。
                    * open var isEmpty: Bool { get }
                    *


                    * // 和view的bounds是不一样的，它获取path的X坐标、Y坐标、宽度，但是高度为0
                    * open var bounds: CGRect { get }
                    *


                    * // 当前path的位置，可以理解为path的终点
                    * open var currentPoint: CGPoint { get }
                    *


                    * // 返回一个布尔值，该值指示指定的点是否在路径包围的区域内。
                    * open func contains(_ point: CGPoint) -> Bool
                    *
                    *


                    * // Drawing properties
                    *
                    * // path宽度
                    * open var lineWidth: CGFloat
                    *


                    * // path端点样式，有3种样式
                    * {
                    * 1. case butt = 0     无断点
                    * 2. case round = 1    圆形断点
                    * 3. case square = 2   方形端点（样式上和butt是一样的，但是比butt长一点）
                    * }
                    * open var lineCapStyle: CGLineCap
                    *


                    * // 拐角样式
                    *{
                    * case miter = 0  尖角
                    * case round = 1  圆角
                    * case bevel = 2  缺角
                    * }
                    * open var lineJoinStyle: CGLineJoin
                    *


                    * // 最大斜接长度（只有在使用lineJoinStyle.miter是才有效）， 边角的角度越小，斜接长度就会越大
                    * // 为了避免斜接长度过长，使用lineLimit属性限制，如果斜接长度超过miterLimit，边角就会以KCALineJoinBevel类型来显示
                    * open var miterLimit: CGFloat // Used when lineJoinStyle is kCGLineJoinMiter
                    *


                    * // 弯曲路径的渲染精度，默认为0.6，越小精度越高，相应的更加消耗性能。
                    * open var flatness: CGFloat
                    *


                    * // 单双数圈规则是否用于绘制路径，默认是NO。
                    * open var usesEvenOddFillRule: Bool // Default is NO. When YES, the even-odd fill rule is used for drawing, clipping, and hit testing.
                    *


                    * // 绘制虚线 pattern: C类型线性数据   count: pattern中数据个数  phase: 起始位置
                    * open func setLineDash(_ pattern: UnsafePointer<CGFloat>?, count: Int, phase: CGFloat)
                    *


                    * // 获取虚线
                    * open func getLineDash(_ pattern: UnsafeMutablePointer<CGFloat>?, count: UnsafeMutablePointer<Int>?, phase: UnsafeMutablePointer<CGFloat>?)
                    *
                    *
                    * // Path operations on the current graphics context
                    *
                    * // 填充
                    * open func fill()
                    *


                    * // 描边，路径创建需要描边才能显示出来
                    * open func stroke()
                    *


                    * // These methods do not affect the blend mode or alpha of the current graphics context
                    *
                    * // 设置填充的混合模式  blendMode:混合模式  alpha:透明度
                    * open func fill(with blendMode: CGBlendMode, alpha: CGFloat)
                    *


                    * // 设置描边的混合模式  blendMode:混合模式  alpha:透明度
                    * open func stroke(with blendMode: CGBlendMode, alpha: CGFloat)
                    *


                    * // 修改当前图形上下文的绘图区域可见,随后的绘图操作导致呈现内容只有发生在指定路径的填充区域
                    * open func addClip()

                   """
        let highlightedCode = highlightr.highlight(code, as: "swift")
        
        let textView = UITextView(frame: self.view.frame)
        textView.isEditable = false
        self.view.addSubview(textView)
        textView.attributedText = highlightedCode
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
