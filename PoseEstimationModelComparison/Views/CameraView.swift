//
//  CameraView.swift
//  PoseEstimationModelComparison
//
//  Created by Samuel Duggan on 22/11/2024.
//
/// Abstract:
/// This module is a custom view created to display the live camera feed.
/// The functionality is controlled by the CameraViewController module
/// The point of this module is so that the PreviewLayer for the CaptureSession created in the CameraViewController can be displayed using SwiftUI
/// It does this by implementing the UIViewControllerRepresentable protocol and implementing its methods to attach it to the CameraViewController.

import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    private let cameraViewController = CameraViewController()
    //This module allows for event handling from camera feed
    class Coordinator : NSObject {
        let parent: CameraView
        init(parent: CameraView) {
            self.parent = parent
        }
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return cameraViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // no updates for now
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
}

