//
//  LineDrawingView.swift
//  PoseEstimationModelComparison
//
//  Created by Samuel Duggan on 02/12/2024.
//

import UIKit

class LineDrawingView: UIView {
    var startPoint: CGPoint = .zero
    var endPoint: CGPoint = .zero
    
    override func draw(_ rect: CGRect) {
        //code adapted from DZoki019 (2020) (StackOverflow)
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)  //Create UIBezierPath object and set start and end point
        
        path.close() //finish adding points to path
        
        UIColor.white.set() //set line colour
        path.lineWidth = 2.0 //set line width
        
        path.stroke() //draw line as configured above
        //end of adapted code
    }
}
