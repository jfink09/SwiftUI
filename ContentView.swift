//
//  ContentView.swift
//  Vascular
//
//  Created by Jason Fink on 5/27/22.
//  Copyright © 2022 Jason. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var wbcPosition = CGPoint(x:200, y:700)
    @State private var rbcPosition = CGPoint(x:250, y:750)
   
    var body: some View {
        
        GeometryReader { geo in
            
            ZStack {
                
                RBC()
                
            }
                
            RBC()
            WBC()
            .frame(width: geo.size.width, height: geo.size.height)
            .position(self.wbcPosition)
            .background(Color(#colorLiteral(red: 0.3525061763, green: 0, blue: 0, alpha: 0.9)))
        }
            .edgesIgnoringSafeArea(.all)
    }
}


