////
////  OverlayView.swift
////  PoseEstimationModelComparison
////
////  Created by Samuel Duggan on 02/12/2024.
////
/////Abstract:
/////This module is typically used as a subview for another view. It is designed to detect human body pose and draw red circles on the keypoints returned from the model.
/////The view must be set up using the bounds of the view you would like to overlay.
/////Calling detectBody on an image (as a CVPixelBuffer) will automatically overlay the keypoints if set up correctly.

//TODO: In process of seperating the OverlayView from the OverlayViewController

import UIKit
import Vision

class OverlayViewController : UIViewController{
    let overlayView = UIView()
    //private let frame: CGRect
//    
//    init(frame: CGRect) {
//        self.frame = frame
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//            fatalError("init(coder:) has not been implemented")
//        }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupOverlayView(frame: frame)
//    }
    
    func setupOverlayView(frame: CGRect){
        DispatchQueue.main.async{
            self.view.frame = frame
            self.view.backgroundColor = .clear
            self.view.addSubview(self.overlayView)
        }
    }
    
    private func drawPoints(_ points: [CGPoint]){
        //TODO: get reference for drawing rectangles
        DispatchQueue.main.async{
            self.view.subviews.forEach{ $0.removeFromSuperview()}
            
            points.forEach{ point in
                let pointView = UIView()
                pointView.frame = CGRect(x: point.x
                                         - 2.5, y: point.y - 2.5, width: 5, height: 5)
                pointView.backgroundColor = .red
                //pointView.layer.cornerRadius = 2.5
                self.view.addSubview(pointView)
            }
            for i in 0..<points.count{
                if i + 1 != points.count{
                    let lineView = LineDrawingView(frame: self.view.bounds)
                    lineView.backgroundColor = .clear
                    lineView.startPoint = CGPoint(x: points[i].x, y: points[i].y)
                    lineView.endPoint = CGPoint(x: points[i+1].x, y: points[i+1].y)
                    self.view.addSubview(lineView)
                }
            }
            
        }
        
    }
    
    private func mapPointsToOverlay(_ points: [CGPoint], in image: CVPixelBuffer) -> [CGPoint] {
        let overlayWidth = CGFloat(view.bounds.width)
        let overlayHeight = CGFloat(view.bounds.height)
        
        return points.map { point in
            let x = point.x * overlayWidth
            let y = (1 - point.y) * overlayHeight
            return CGPoint(x: x, y: y)
            
        }
    }
    
    func detectBody(in image: CVPixelBuffer){
        //code adapted from Tustanowski (2023) and Ajwani (2019)
        let bodyPoseRequest = VNDetectHumanBodyPoseRequest(completionHandler: { (request: VNRequest, error: Error?) in
            DispatchQueue.main.async{
                guard let results = request.results as? [VNHumanBodyPoseObservation]
                else{
                    print("Not detecting any people")
                    return
                }
                
                
                let normalisedPoints = results.flatMap{ result in
                    result.availableJointNames
                        .compactMap{jointName in
                            try? result.recognizedPoint(jointName)}
                        .filter { $0.confidence > 0.1}
                }
                let points = normalisedPoints.map{ $0.location }
                let mappedPoints = self.mapPointsToOverlay(points, in: image)
                self.drawPoints(mappedPoints)
            }
            
            //guard let results = request.results as? [VNHumanBodyPoseObservation] //stores results from request in array if they exist, can detect multiple people so .first refers to the first person it detects
             //else {
             //   print("Vision body pose request did not return any results")
             //   return
            //}
            
            
        })
        
        let requestHandler = VNImageRequestHandler(cvPixelBuffer: image, orientation: .upMirrored , options: [:])
        do{
            try requestHandler.perform([bodyPoseRequest])
        } catch{
            print("Can't make request due to \(error)")
        }
        //end of adapted code
        
        
    }
}
//import UIKit
//import Vision

//class OverlayViewController: UIViewController {
//    let overlayView = OverlayView()
//    
////    private let frame: CGRect
////
////    init(frame: CGRect) {
////        self.frame = frame
////        super.init(nibName: nil, bundle: nil)
////    }
////
////    required init?(coder: NSCoder) {
////            fatalError("init(coder:) has not been implemented")
////        }
////
////    override func viewDidLoad() {
////        super.viewDidLoad()
////        setupOverlayView(frame: frame)
////    }
//    
//    func setupOverlayView(frame: CGRect) {
//        DispatchQueue.main.async {
//            self.view.frame = frame
//            self.view.backgroundColor = .clear
//            self.overlayView.frame = frame
//            self.overlayView.backgroundColor = .clear
//            self.overlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            self.view.addSubview(self.overlayView)
//        }
//    }
//
//    func detectBody(in image: CVPixelBuffer) {
//        let bodyPoseRequest = VNDetectHumanBodyPoseRequest { request, error in
//            DispatchQueue.main.async {
//                guard let results = request.results as? [VNHumanBodyPoseObservation] else {
//                    print("Not detecting any people")
//                    return
//                }
//                let normalizedPoints = results.flatMap { observation in
//                    observation.availableJointNames.compactMap { jointName in
//                        try? observation.recognizedPoint(jointName)
//                    }.filter { $0.confidence > 0.1 }
//                }
//                let points = normalizedPoints.map { $0.location }
//                let mappedPoints = self.mapPointsToOverlay(points, in: image)
//                self.overlayView.drawPoints(mappedPoints)
//            }
//        }
//
//        let requestHandler = VNImageRequestHandler(cvPixelBuffer: image, orientation: .upMirrored, options: [:])
//        do {
//            try requestHandler.perform([bodyPoseRequest])
//        } catch {
//            print("Can't make request due to \(error)")
//        }
//    }
//
//    private func mapPointsToOverlay(_ points: [CGPoint], in image: CVPixelBuffer) -> [CGPoint] {
//        let overlayWidth = CGFloat(view.bounds.width)
//        let overlayHeight = CGFloat(view.bounds.height)
//        
//        return points.map { point in
//            let x = point.x * overlayWidth
//            let y = (1 - point.y) * overlayHeight
//            return CGPoint(x: x, y: y)
//        }
//    }
//}
