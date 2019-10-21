//
//  Example11.swift
//  Paths
//
//  Created by EDGARDO AGNO on 20/10/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

// MARK: - Example 11
struct Example11: View {
    @State private var animate = false
    
    var body: some View {
        
        let gradient1: [UIColor] = [.blue, .green]
        let gradient2: [UIColor] = [.red, .yellow]
        
        return VStack {
            Spacer()
            
            Color.clear.frame(width: 200, height: 200)
                .overlay(Color.clear.modifier(AnimatableGradient(from: gradient1, to: gradient2, pct: animate ? 1 : 0)))
            
            Spacer()
            
            Button("Toggle Gradient") {
                withAnimation(.easeInOut(duration: 1.0)) {
                    self.animate.toggle()
                }
            }
        }.navigationBarTitle("Example 11")
    }
}

struct AnimatableGradient: AnimatableModifier {
    let from: [UIColor]
    let to: [UIColor]
    var pct: CGFloat = 0
    
    var animatableData: CGFloat {
        get { pct }
        set { pct = newValue }
    }
    
    func body(content: Content) -> some View {
        var gColors = [Color]()
        
        for i in 0..<from.count {
            gColors.append(colorMixer(c1: from[i], c2: to[i], pct: pct))
        }
        
        return RoundedRectangle(cornerRadius: 15)
            .fill(LinearGradient(gradient: Gradient(colors: gColors),
                                 startPoint: UnitPoint(x: 0, y: 0),
                                 endPoint: UnitPoint(x: 1, y: 1)))
            .frame(width: 200, height: 200)
    }
    
    // This is a very basic implementation of a color interpolation
    // between two values.
    func colorMixer(c1: UIColor, c2: UIColor, pct: CGFloat) -> Color {
        guard let cc1 = c1.cgColor.components else { return Color(c1) }
        guard let cc2 = c2.cgColor.components else { return Color(c1) }
        
        let r = (cc1[0] + (cc2[0] - cc1[0]) * pct)
        let g = (cc1[1] + (cc2[1] - cc1[1]) * pct)
        let b = (cc1[2] + (cc2[2] - cc1[2]) * pct)

        return Color(red: Double(r), green: Double(g), blue: Double(b))
    }
}

struct Example11_Previews: PreviewProvider {
    static var previews: some View {
        Example11()        
    }
}
