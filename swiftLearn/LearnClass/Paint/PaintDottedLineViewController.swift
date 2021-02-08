//
//  PaintDottedLineViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/1/29.
//

import UIKit

//绘制虚线
class PaintDottedLineViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let shapeLayer = CAShapeLayer()
        let size = self.view.frame.size
        
        let shapeRect = CGRect(x: 10, y: 10, width: 200, height: 200)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        //
        shapeLayer.lineDashPattern = [3,4]
        let path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5)
        shapeLayer.path = path.cgPath
        self.view.layer.addSublayer(shapeLayer)
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
