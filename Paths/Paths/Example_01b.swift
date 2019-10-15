//
//  Example_01b.swift
//  Paths
//
//  Created by EDGARDO AGNO on 15/10/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

struct Example01b: View {
    @State private var half = false
    @State private var dim = false
    
    var body: some View {
        Image("back")
            .opacity(dim ? 0.2 : 1.0)
            .animation(.easeInOut(duration: 1.0))
            .scaleEffect(half ? 0.5 : 1.0)
            .onTapGesture {
                self.dim.toggle()
                self.half.toggle()
        }
    }
}
