//
//  Helicopter.swift
//  Helicopter
//
//  Created by Jason Fink on 5/25/22.
//  Copyright © 2022 Jason. All rights reserved.
//

import SwiftUI

struct Helicopter: View {
    
    let rows = 5
    let columns = 5
    let size: CGFloat = 10
    let heliBlocks: [[Color]] = [[.gray,.gray,.gray,.gray,.gray],
                                 [.clear,.clear,.blue,.clear,.clear],
                                 [.orange,.orange,.orange,.orange,.gray],
                                 [.clear,.clear,.orange,.orange,.orange],
                                 [.clear,.clear,.gray,.clear,.gray]]
    
    var body: some View {
        
        VStack (spacing: 0) {
            ForEach((0...self.rows - 1), id: \.self) { row in
                HStack (spacing: 0) {
                    ForEach((0...self.columns - 1), id: \.self) { col in
                        VStack (spacing: 0) {
                            Rectangle()
                                .frame(width: self.size, height: self.size)
                                .foregroundColor(self.heliBlocks[row][col])
                        }
                    }
                }
            }
        }
    }
}
