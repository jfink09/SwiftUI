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
    @State private var isPaused = false
    
    @State var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

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
                            self.obstacleMove()
                            }
                    
                    self.isPaused ? Button ("Restart") {self.resume()} : nil
                    
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
                    .onReceive(self.timer) {_ in self.collisionDetection() }
            }
        .edgesIgnoringSafeArea(.all)
    }
    
    func gravity() {
        withAnimation{
        self.heliPosition.y += 20
        }
    }
    func obstacleMove() {
        if self.obstaclePosition.x > 0
        {
            withAnimation{
                self.obstaclePosition.x -= 35
            }
        }
        else
        { self.obstaclePosition.x = 1000 }
    }
    
    func pause() {
        self.timer.upstream.connect().cancel()
    }
    
    func resume() {
        self.timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
        self.obstaclePosition.x = 1000 // Move the obstacle to the original position
        self.heliPosition = CGPoint(x: 100, y: 100)
    }
    
    func collisionDetection() {
        if abs(heliPosition.x - obstaclePosition.x) < (25 + 10) && abs(heliPosition.y - obstaclePosition.y) < (25 + 100) {
            self.pause()
            self.isPaused = true
        }
    }
}
