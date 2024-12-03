//
//  ContentView.swift
//  PoseEstimationModelComparison
//
//  Created by Samuel Duggan on 22/11/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Color.brown.opacity(0.3)
            .ignoresSafeArea()
            .overlay{
            VStack{
                CameraView()
                    .frame(width: 300, height: 500)
                HStack{
                    Button(action: {}){
                        Text("Vision")
                            .padding()
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .foregroundColor(Color.black)
                    }
                    Spacer()
                    Button(action: {}){
                        Text("OpenPose")
                            .padding()
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .foregroundColor(Color.black)
                    }
                    Spacer()
                    Button(action: {}){
                        Text("MoveNet")
                            .padding()
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .foregroundColor(Color.black)
                    }
                }.padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
