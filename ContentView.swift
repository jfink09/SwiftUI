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
    @State private var ceilingPosition = CGPoint(x:0, y:10)
    @State private var floorPosition = CGPoint(x:0, y:405)
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
                    
                    Ceiling()
                    .position(self.ceilingPosition)
                    .onReceive(self.timer) {_ in
                        self.ceilingMove()
                        }
                    
                    Floor()
                    .position(self.floorPosition)
                    .onReceive(self.timer) {_ in
                        self.floorMove()
                        }
                    
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
    
    func ceilingMove() {
        if self.ceilingPosition.x >= 0
        {
            withAnimation{
                self.ceilingPosition.x = 0
            }
        }
    }
    
    func floorMove() {
        if self.floorPosition.x >= 0
        {
            withAnimation{
                self.floorPosition.x = 0
            }
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
        if abs(heliPosition.x - obstaclePosition.x) < (25 + 10) && abs(heliPosition.y - obstaclePosition.y) < (25 + 60) {
            self.pause()
            self.isPaused = true
        }
        if abs(heliPosition.x - ceilingPosition.x) < (25 + 1000) && abs(heliPosition.y - ceilingPosition.y) < (25 + 2) {
            self.pause()
            self.isPaused = true
        }
        if abs(heliPosition.x - floorPosition.x) < (25 + 1000) && abs(heliPosition.y - floorPosition.y) < (25 + 5) {
            self.pause()
            self.isPaused = true
        }
    }
}
