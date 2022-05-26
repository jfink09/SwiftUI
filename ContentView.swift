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
    @State private var score = 0
    
    @State var timer = Timer.publish(every: 0.06, on: .main, in: .common).autoconnect()

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
                    
                    Text("\(self.score)")
                        .foregroundColor(.white)
                        .position(x: geo.size.width - 100, y: geo.size.height / 10)
                    
                    self.isPaused ? Button ("Restart") {self.resume()}
                        .foregroundColor(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/): nil
                    
                }
                        .frame(width: geo.size.width, height: geo.size.height)
                        .background(Color.black)
            .gesture(
                TapGesture()
                    .onEnded{
                        withAnimation{
                        self.heliPosition.y -= 100
                        }
            })
                    .onReceive(self.timer) {_ in
                        self.collisionDetection()
                        self.score += 1
                }
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
        {
        self.obstaclePosition.x = 1000
            self.obstaclePosition.y = CGFloat.random(in: 0...500)
        }
    }
    
    func pause() {
        self.timer.upstream.connect().cancel()
    }
    
    func resume() {
        self.timer = Timer.publish(every: 0.06, on: .main, in: .common).autoconnect()
        self.obstaclePosition.x = 1000 // Move the obstacle to the original position
        self.heliPosition = CGPoint(x: 100, y: 100)
        self.isPaused = false
        self.score = 0
    }
    
    func collisionDetection() {
        if abs(heliPosition.x - obstaclePosition.x) < (25 + 10) && abs(heliPosition.y - obstaclePosition.y) < (25 + 100) {
            self.pause()
            self.isPaused = true
        }
    }
}
