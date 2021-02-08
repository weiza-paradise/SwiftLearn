//
//  PaintTriangleViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/1/28.
//

import UIKit

class PaintTriangleViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        paintTriangle()
    }
    
    deinit {
        print("PaintTriangleViewController deinit")
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

extension PaintTriangleViewController {
    
    fileprivate func paintTriangle() {
        
        let path = UIBezierPath()
        
        //起点
        path.move(to: CGPoint(x: 20, y: 200))
        //layer上经过的其他点.连在一起
        path.addLine(to: CGPoint(x: 30, y: 150))
        path.addLine(to: CGPoint(x: 120, y:200))
        //图层封闭
        path.close()
        
        let layer = CAShapeLayer()
        layer.path        = path.cgPath
        layer.lineWidth   = 1
        layer.strokeColor = UIColor.orange.cgColor
        layer.fillColor   = UIColor.clear.cgColor
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue   = 1
        animation.duration  = 2
        layer.add(animation, forKey: "")
        
        self.view.layer.addSublayer(layer)
    }
    
}
