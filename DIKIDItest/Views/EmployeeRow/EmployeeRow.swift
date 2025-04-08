//
//  EmployeeRow.swift
//  DIKIDItest
//
//  Created by Владислав Соколов on 07.04.2025.
//

import SwiftUI

struct EmployeeRow: View {
    
    @StateObject private var imageViewModel = ImageLoaderViewModel(imageApi: NetworkImageManager())
        
    @State private var offsetX: CGFloat = 0
    
    @Namespace private var tapped
    
    @GestureState private var dragOffset: CGFloat = 0
    
    let employee: MainList

    private let actionWidth: CGFloat = 55
    private let totalActions = 4
    
    var body: some View {
        ZStack(alignment: .trailing) {
            
            swipeButtons
            
            VStack {
                mainField
            }
            .offset(x: offsetX + dragOffset)
            .simultaneousGesture(
                DragGesture()
                    .onChanged { value in
                        let horizontalAmount = abs(value.translation.width)
                        let verticalAmount = abs(value.translation.height)
                        
                        if horizontalAmount > verticalAmount {
                            if value.translation.width < 0 {
                                let proposedOffset = value.translation.width
                                if proposedOffset > -actionWidth * CGFloat(totalActions) {
                                    self.offsetX = proposedOffset
                                }
                            }
                        }
                    }
                    .onEnded { value in
                        let horizontalAmount = abs(value.translation.width)
                        let verticalAmount = abs(value.translation.height)
                        
                        if horizontalAmount > verticalAmount {
                            withAnimation(.easeOut(duration: 0.2)) {
                                if value.translation.width < -actionWidth * 2 {
                                    offsetX = -actionWidth * CGFloat(totalActions)
                                } else {
                                    offsetX = 0
                                }
                            }
                        }
                    }
            )
            .onTapGesture {
                if offsetX != 0 {
                    withAnimation {
                        offsetX = 0
                    }
                }
            }
        }
        .background(Color.white)
        .task {
            await imageViewModel.loadImage(from: employee.employee.icon)
        }
    }
    
    private var mainField: some View {
        HStack {
            if let image = imageViewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 36, height: 36)
                    .clipShape(.rect(cornerRadius: 10))
            } else {
                ProgressView()
                    .frame(width: 36, height: 36)
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(employee.employee.fullname)
                    .font(.system(size: 15))
                    .lineLimit(1)

                Text(employee.employee.categoryTitle)
                    .font(.system(size: 13))
                    .foregroundStyle(.gray)
                    .lineLimit(1)
            }
            .frame(maxWidth: 140, alignment: .leading)

            Spacer()

            if let overpayment = employee.overpaymentEnd, !overpayment.isEmpty {
                VStack(alignment: .trailing, spacing: 6) {
                    Text(employee.payroll.formattedAsCurrency)
                        .foregroundStyle(.count)
                        .font(.system(size: 15).weight(.semibold))
                    
                    Text("Переплата \(employee.overpaymentEnd?.formattedAsCurrency ?? "0")")
                        .foregroundStyle(.red)
                        .font(.system(size: 11))
                }
            } else {
                Text(employee.payroll.formattedAsCurrency)
                    .foregroundStyle(.count)
                    .font(.system(size: 15).weight(.semibold))
            }

            Image(systemName: "chevron.right")
                .foregroundStyle(.gray)
        }
        .padding(.horizontal, 16)
        .frame(height: 60)
        .background(Color.white)
        .contentShape(Rectangle())
    }
    
    private var swipeButtons: some View {
        HStack(spacing: 1) {
            Button {
                print("Settings")
            } label: {
                Image(systemName: "gearshape")
                    .frame(width: actionWidth, height: 50)
                    .background(.swipeAction)
                    .foregroundColor(.white)
            }
            Button {
                print("Plus")
            } label: {
                Image(systemName: "plus.circle")
                    .frame(width: actionWidth, height: 50)
                    .background(.swipeAction)
                    .foregroundColor(.white)
            }
            Button {
                print("Minus")
            } label: {
                Image(systemName: "minus.circle")
                    .frame(width: actionWidth, height: 50)
                    .background(.swipeAction)
                    .foregroundColor(.white)
            }
            
            Button {
                print("Send")
            } label: {
                Image(systemName: "arrow.right.circle")
                    .frame(width: actionWidth, height: 50)
                    .background(.swipeAction)
                    .foregroundColor(.white)
            }
        }
        .frame(width: actionWidth * CGFloat(totalActions), alignment: .trailing)
    }
}
