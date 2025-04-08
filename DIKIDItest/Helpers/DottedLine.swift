//
//  DottedLine.swift
//  DIKIDItest
//
//  Created by Владислав Соколов on 07.04.2025.
//

import SwiftUI

struct DottedLine: View {
    let dotSpacing: CGFloat
    let dotSize: CGFloat
    let dotColor: Color
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: dotSpacing) {
                ForEach(0..<Int(geometry.size.width / (dotSize + dotSpacing)), id: \.self) { _ in
                    Circle()
                        .fill(dotColor)
                        .frame(width: dotSize, height: dotSize)
                }
            }
            .padding(.top, 2)
        }
        .frame(height: dotSize)
    }
}
