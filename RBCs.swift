//
//  RBCs.swift
//  Vascular
//
//  Created by Jason Fink on 5/27/22.
//  Copyright © 2022 Jason. All rights reserved.
//

import SwiftUI

struct RBC: View {
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
            
                ZStack {
                    Circle()
                        .fill(Color(#colorLiteral(red: 0.6115235697, green: 0, blue: 0.03921568627, alpha: 1)))
                        .padding(10)
                    
                    Circle()
                        .fill(Color(#colorLiteral(red: 0.5725490196, green: 0, blue: 0.03921568627, alpha: 1)))
                        .padding(18)
                }
                .frame(width: 50, height: 50)
                .padding()
            }
        }
    }

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
  //      ContentView()
   //     }
  //  }
}
