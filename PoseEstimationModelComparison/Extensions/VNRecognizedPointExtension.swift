//
//  VNRecognizedPointExtension.swift
//  PoseEstimationModelComparison
//
//  Created by Samuel Duggan on 02/12/2024.
//

import Vision

extension VNRecognizedPoint {
    func location(in image: CVPixelBuffer) -> CGPoint {
        VNImagePointForNormalizedPoint(location, Int(CVPixelBufferGetWidth(image)), Int(CVPixelBufferGetHeight(image)))
    }
}
