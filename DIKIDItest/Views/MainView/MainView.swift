//
//  MainView.swift
//  DIKIDItest
//
//  Created by Владислав Соколов on 06.04.2025.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var viewModel = MainViewModel(networkManager: NetworkManager())
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.main, .gray.opacity(0.1)], startPoint: UnitPoint(x: 0.3, y: 0.5), endPoint: UnitPoint(x: 0.3, y: 0.76))
                    .ignoresSafeArea()
                
                VStack {
                    dateField
                    
                    balanceField
                    
                    HStack {
                        Text("сотрудники")
                            .font(.system(size: 20))
                            .padding(.leading, 36)
                        
                        Spacer()
                        
                        Button {
                            // action
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                                .font(.system(size: 23))
                        }
                        .padding(.trailing, 20)
                        
                    }
                    .padding(.top, 20)
                    .foregroundStyle(.white.opacity(0.6))
                    
                    
                    employeeList
                    
                    Spacer()
                }
            }
            .task {
                await viewModel.fetchBalance()
                await viewModel.fetchEmployee()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    .foregroundStyle(.white)
                    .padding(.trailing, 30)
                }
                ToolbarItem(placement: .topBarLeading) {
                    CustomTabControl()
                }
                ToolbarItem {
                    HStack(spacing: 0) {
                        Button {
                            // action
                        } label: {
                            Image(systemName: "questionmark.circle")
                        }
                        .foregroundStyle(.white)
                        
                        Button {
                            // action
                        } label: {
                            Image(systemName: "gearshape")
                        }
                        .foregroundStyle(.white)
                    }
                }
                
            }
        }
        
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.all, edges: .top)
    }
    
    private var balanceField: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 2) {
                Text("Остаток")
                    .foregroundStyle(.white.opacity(0.8))
                    .font(.system(size: 17))
                
                Text(viewModel.balance?.balance.formattedAsCurrency ?? "0")
                    .foregroundStyle(.white)
                    .font(.system(size: 30).weight(.bold))
                
                HStack(spacing: 2) {
                    Text("К выплате:")
                        .background(alignment: .bottom) {
                            DottedLine(dotSpacing: 2, dotSize: 2, dotColor: .white.opacity(0.5))
                        }
                    Text(viewModel.balance?.balance.formattedAsCurrency ?? "0")
                }
                .font(.system(size: 13))
                .foregroundStyle(.white.opacity(0.5))
            }
            
            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 6) {
                    Text("Переплата")
                        .font(.system(size: 17))
                    
                    Button {
                        // action
                    } label: {
                        Image(systemName: "info.circle")
                            .font(.system(size: 16))
                    }
                    
                }
                .padding(.top, 12)
                .foregroundStyle(.white.opacity(0.8))
                
                Text(viewModel.balance?.overpaymentEnd?.formattedAsCurrency ?? "0")
                    .foregroundStyle(.white)
                    .font(.system(size: 20).weight(.bold))
                
                HStack(spacing: 2) {
                    Text("К удержанию:")
                        .background(alignment: .bottom) {
                            DottedLine(dotSpacing: 2, dotSize: 2, dotColor: .white.opacity(0.5))
                        }
                    Text(viewModel.balance?.deduction.formattedAsCurrency ?? "0")
                }
                .font(.system(size: 13))
                .foregroundStyle(.white.opacity(0.5))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(
                    LinearGradient(colors: [.date, .gradient.opacity(0.7)], startPoint: UnitPoint(x: 0.3, y: 0.4), endPoint: UnitPoint(x: 1, y: 0.2))
                )
        }
        .padding(.horizontal, 16)
        .padding(.top, 20)
    }
    
    private var dateField: some View {
        HStack(spacing: 4) {
            Text("На текущий момент")
                .foregroundStyle(.white)
            
            Button {
                // action
            } label: {
                Image(systemName: "chevron.up.chevron.down")
                    .font(.system(size: 15))
            }
            .foregroundStyle(.white)
            
            Spacer()
            
            Text("11 января")
                .foregroundStyle(.white)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.date)
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
    
    private var employeeList: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
            
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(Array(viewModel.employee.enumerated()), id: \.element) { index, employee in
                        EmployeeRow(employee: employee)
                            .padding(.bottom, index == viewModel.employee.count - 1 ? 16 : 0)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    MainView()
}
