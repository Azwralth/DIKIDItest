//
//  CustomTabControl.swift
//  DIKIDItest
//
//  Created by Владислав Соколов on 08.04.2025.
//

import SwiftUI

struct CustomTabControl: View {
    @State private var selectedTab = 0
    @Namespace private var namespace
    
    let tabs = ["Остаток", "Расчеты", "Операции"]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<tabs.count, id: \.self) { index in
                Button {
                    withAnimation(.easeInOut) {
                        selectedTab = index
                    }
                } label: {
                    HStack(spacing: 0) {
                        Text(tabs[index])
                            .padding([.vertical, .horizontal], 2)
                            .font(.system(size: 13))
                            .foregroundStyle(.white)
  
                    }
                }
                .background {
                    if selectedTab == index {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white.opacity(0.3))
                            .matchedGeometryEffect(id: "selectedTab", in: namespace)
                    }
                }
            }
        }
        .padding(3)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white.opacity(0.2))
        )
    }
}
