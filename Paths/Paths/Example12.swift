//
//  Example12.swift
//  Paths
//
//  Created by EDGARDO AGNO on 20/10/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

// MARK: - Example 12
extension Double {
    var rad: Double { return self * .pi / 180 }
    var deg: Double { return self * 180 / .pi }
}

struct Example12: View {
    @State private var flag = false
    
    var body: some View {
        VStack {
            Spacer()
            Color.clear.overlay(WaveText("The SwiftUI Lab", waveWidth: 6, pct: flag ? 1.0 : 0.0).foregroundColor(.blue)).frame(height: 40)
            Color.clear.overlay(WaveText("swiftui-lab.com", waveWidth: 6, pct: flag ? 0.0 : 1.0, size: 18).foregroundColor(.green)).frame(height: 30)
            Spacer()
        }.onAppear {
            withAnimation(Animation.easeInOut(duration: 2.0).repeatForever()) {
                self.flag.toggle()
            }
        }.navigationBarTitle("Example 12")
    }
}

struct WaveText: View {
    let text: String
    let pct: Double
    let waveWidth: Int
    var size: CGFloat
    
    init(_ text: String, waveWidth: Int, pct: Double, size: CGFloat = 34) {
        self.text = text
        self.waveWidth = waveWidth
        self.pct = pct
        self.size = size
    }
    
    var body: some View {
        Text(text).foregroundColor(Color.clear).modifier(WaveTextModifier(text: text, waveWidth: waveWidth, pct: pct, size: size))
    }
    
    struct WaveTextModifier: AnimatableModifier {
        let text: String
        let waveWidth: Int
        var pct: Double
        var size: CGFloat
        
        var animatableData: Double {
            get { pct }
            set { pct = newValue }
        }
        
        func body(content: Content) -> some View {
            
            HStack(spacing: 0) {
                ForEach(Array(text.enumerated()), id: \.0) { (n, ch) in
                    Text(String(ch))
                        .font(Font.custom("Menlo", size: self.size).bold())
                        .scaleEffect(self.effect(self.pct, n, self.text.count, Double(self.waveWidth)))
                }
            }
        }
        
        func effect(_ pct: Double, _ n: Int, _ total: Int, _ waveWidth: Double) -> CGFloat {
            let n = Double(n)
            let total = Double(total)
            
            return CGFloat(1 + valueInCurve(pct: pct, total: total, x: n/total, waveWidth: waveWidth))
        }
        
        func valueInCurve(pct: Double, total: Double, x: Double, waveWidth: Double) -> Double {
            let chunk = waveWidth / total
            let m = 1 / chunk
            let offset = (chunk - (1 / total)) * pct
            let lowerLimit = (pct - chunk) + offset
            let upperLimit = (pct) + offset

            guard x >= lowerLimit && x < upperLimit else { return 0 }
            
            let angle = ((x - pct - offset) * m)*360-90
            
            return (sin(angle.rad) + 1) / 2
        }
    }
}
