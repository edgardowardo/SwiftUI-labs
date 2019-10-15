//------------------------------------------------------------------------
// The SwiftUI Lab: Advanced SwiftUI Animations
// https://swiftui-lab.com/swiftui-animations-part1 (Animating Paths)
// https://swiftui-lab.com/swiftui-animations-part2 (GeometryEffect)
// https://swiftui-lab.com/swiftui-animations-part3 (AnimatableModifier)
//------------------------------------------------------------------------

import SwiftUI

// MARK: - Example 3: Polygon with multiple animatable paramters
struct Example3: View {
    @State private var sides: Double = 4
    @State private var duration: Double = 1.0
    @State private var scale: Double = 1.0
    
    var body: some View {
        VStack {
            Example3PolygonShape(sides: sides, scale: scale)
                .stroke(Color.purple, lineWidth: 5)
                .padding(20)
                .animation(.easeInOut(duration: duration))
                .layoutPriority(1)
            
            Text("\(Int(sides)) sides, \(String(format: "%.2f", scale as Double)) scale")
            
            HStack(spacing: 20) {
                MyButton(label: "1") {
                    self.duration = self.animationTime(before: self.sides, after: 1)
                    self.sides = 1.0
                    self.scale = 1.0
                }
                
                MyButton(label: "3") {
                    self.duration = self.animationTime(before: self.sides, after: 3)
                    self.sides = 3.0
                    self.scale = 0.7
                }
                
                MyButton(label: "7") {
                    self.duration = self.animationTime(before: self.sides, after: 7)
                    self.sides = 7.0
                    self.scale = 0.4
                }
                
                MyButton(label: "30") {
                    self.duration = self.animationTime(before: self.sides, after: 30)
                    self.sides = 30.0
                    self.scale = 1.0
                }
                
            }
        }.navigationBarTitle("Example 3").padding(.bottom, 50)
    }
    
    func animationTime(before: Double, after: Double) -> Double {
        // Calculate an animation time that is
        // adequate to the number of sides to add/remove.
        return abs(before - after) * (1 / abs(before - after))
    }
}


struct Example3PolygonShape: Shape {
    var sides: Double
    var scale: Double
    
    var animatableData: AnimatablePair<Double, Double> {
        get { AnimatablePair(sides, scale) }
        set {
            sides = newValue.first
            scale = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        // hypotenuse
        let h = Double(min(rect.size.width, rect.size.height)) / 2.0 * scale
        
        // center
        let c = CGPoint(x: rect.size.width / 2.0, y: rect.size.height / 2.0)
        
        var path = Path()
        
        let extra: Int = sides != Double(Int(sides)) ? 1 : 0
        
        for i in 0..<Int(sides) + extra {
            let angle = (Double(i) * (360.0 / sides)) * (Double.pi / 180)
            
            // Calculate vertex
            let pt = CGPoint(x: c.x + CGFloat(cos(angle) * h), y: c.y + CGFloat(sin(angle) * h))
            
            if i == 0 {
                path.move(to: pt) // move to first vertex
            } else {
                path.addLine(to: pt) // draw line to next vertex
            }
        }
        
        path.closeSubpath()
        
        return path
    }
}

struct Example3_Previews: PreviewProvider {
    static var previews: some View {
        Example3()
    }
}
