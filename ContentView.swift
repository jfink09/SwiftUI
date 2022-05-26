//
//  ContentView.swift
//  Helicopter
//
//  Created by Jason Fink on 5/25/22.
//  Copyright © 2022 Jason. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var heliPosition = CGPoint(x:100, y:100)
    @State private var obstaclePosition = CGPoint(x:1000, y:300)
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    var body: some View {
                
            GeometryReader { geo in
            
                ZStack {
                    
                    Helicopter()
                        .position(self.heliPosition)
                        .onReceive(self.timer) {_ in
                            self.gravity()
                    }
                    
                    Obstacle()
                        .position(self.obstaclePosition)
                        .onReceive(self.timer) {_ in
                            withAnimation{
                            self.obstacleMove()
                            }
                    }
                    
                }
                        .frame(width: geo.size.width, height: geo.size.height)
                        .background(Color.black)
            .gesture(
                TapGesture()
                    .onEnded{
                        withAnimation{
                        self.heliPosition.y -= 75
                        }
            })
            }
        .edgesIgnoringSafeArea(.all)
    }
    
    func gravity() {
        withAnimation{
        self.heliPosition.y += 20
        }
    }
    func obstacleMove() {
        self.obstaclePosition.x -= 35
    }
    
}
