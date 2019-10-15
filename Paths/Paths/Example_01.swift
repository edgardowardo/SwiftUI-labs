//
//  Example_01.swift
//  Paths
//
//  Created by EDGARDO AGNO on 15/10/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

struct Example01: View {
    @State private var half = false
    @State private var dim = false
    
    var body: some View {
        Image("back")
            .scaleEffect(half ? 0.5 : 1.0)
            .opacity(dim ? 0.2 : 1.0)
            .animation(.easeInOut(duration: 1.0))
//            .onAppear(perform: {
//                self.dim.toggle()
//                self.half.toggle()
//            })
            .onTapGesture {
                self.dim.toggle()
                self.half.toggle()
            }
    }
}
