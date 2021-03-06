//
//  ContentView.swift
//  MunuButton
//
//  Created by Artyom Ma  on 11/10/21.
//

import SwiftUI

struct MenuView: View {
    
    @State private var animate = false
    @State private var rotation: Double = 0
    @State private var trim: CGFloat = 0
    
    var body: some View {
        
        ZStack {
            Circle()
                .trim(from: 0 , to: trim)
                .stroke(lineWidth: 4)
                .rotate(.degrees(rotation - 90.0))
            Menu(animate: animate)
                .stroke(Color.black, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .frame(100)
        }
        .rotate(.degrees(rotation))
    }
    .frame(250)
    .onTapGesture {
        withAnimation(Animation.linear(duration: 0.5)) {
            if self.animate {
                self.rotation = 0
                self.trim = 0
            } else {
                self.rotation = 180
                self.trim = 1
            }
            self.animate.toggle()
        }
    }
}
struct MenuButton_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
struct Menu: Shape {
    private let layoutConfig = LayoutGuideConfig.grid(colums: 2, rows: 2)
    private var factor: Double
    
    init(animate: Bool = true) {
        self.factor = animate ? 1 : 0
    }
    var animateData: Double {
        get { factor }
        set { factor = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        var g = layoutConfig.layout(in: rect)
        
        path.move(g[0, 0])
        path.line(g[2, 0].to(g[2, 2], factor))
        
        path.move(g[0, 1].to([1, 1], factor))
        path.line(g[2, 1].to(g[1, 1], factor))
        path.move(g[0, 2])
        path.line(g[2, 2].to(g[2, 0], factor))
        
        return path 
    }
}
