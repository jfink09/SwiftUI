//
//  WBC.swift
//  Vascular
//
//  Created by Jason Fink on 5/27/22.
//  Copyright © 2022 Jason. All rights reserved.
//

import SwiftUI

struct WBC: View {
    
    let size: CGFloat = 40
     
     var body: some View {
         Circle()
             .frame(width: size, height: size)
             .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
     }
}
