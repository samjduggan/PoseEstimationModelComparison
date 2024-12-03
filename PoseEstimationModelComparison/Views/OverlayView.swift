//
//  OverlayView.swift
//  PoseEstimationModelComparison
//
//  Created by Samuel Duggan on 03/12/2024.
//

//TODO: This module is not currently in use, in development (to seperate the OverlayView from the OverlayViewController)
///(the current implementation gives sole responsibility to the OverlayViewController to create the view, apply pose estimation and draw the points on the view. This is to apply the single responsibility principle)

import UIKit

class OverlayView: UIView {
    private var points: [CGPoint] = []
    
    func updatePoints(_ points: [CGPoint]) {
        self.points = points
        setNeedsDisplay() // Triggers a redraw
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        // Clear previous drawings
        context.clear(rect)
        
        // Draw points
        for point in points {
            let circleRect = CGRect(x: point.x - 2.5, y: point.y - 2.5, width: 5, height: 5)
            context.setFillColor(UIColor.red.cgColor)
            context.fillEllipse(in: circleRect)
        }
        
        // Draw lines between points (doesnt currently link correct points together for skeleton)
        if points.count > 0{
            for i in 0..<points.count - 1 {
                        context.setStrokeColor(UIColor.red.cgColor)
                        context.setLineWidth(2.0)
                        context.move(to: points[i])
                        context.addLine(to: points[i + 1])
                        context.strokePath()
                    }
        }
        
    }
}
