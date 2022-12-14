//
//  Constant.swift
//  EmpulseHirs
//
//  Created by apple on 22/08/22.
//


import UIKit
import NVActivityIndicatorView
var baseURLStr = ""
var PunchType = ""
var lat = ""
var long = ""
var punchTime = ""
//MARK: - Screen width.
public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}

//MARK: - Screen height.
public var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}
let frame = CGRect(x: screenWidth/2-40, y: screenHeight/2-40, width: 80, height: 80)
public var activityIndicator = NVActivityIndicatorView(frame: frame, type: .lineSpinFadeLoader, color: UIColor.black, padding: 0)
extension UIView {
    func addGradient(colors: [UIColor] = [.blue, .green], locations: [NSNumber] = [0, 2], startPoint: CGPoint = CGPoint(x: 0.0, y: 1.0), endPoint: CGPoint = CGPoint(x: 1.0, y: 1.0), type: CAGradientLayerType = .axial){
        let gradient = CAGradientLayer()
        gradient.frame.size = self.frame.size
        gradient.frame.origin = CGPoint(x: 0.0, y: 0.0)
        gradient.colors = colors.map{ $0.cgColor }
        gradient.locations = locations
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        self.layer.insertSublayer(gradient, at: 0)
    }
}


