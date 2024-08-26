//
//  SideMenuHeaderView.swift
//  worshipHelper
//
//  Created by BBOB on 2024/8/16.
//

import SwiftUI

struct sideMenuHeaderView: View {
    @Binding var isShowing: Bool
    @Environment(\.colorScheme) var colorScheme // 观察暗黑模式

    var body: some View {
        ZStack(alignment: .topTrailing) {
            // 背景顏色
            VStack {
                LinearGradient(
                                gradient: Gradient(colors: [ Color(hex: "8e7cc3"), ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            .frame(height: 150) // 設定背景高度
                            .ignoresSafeArea(edges: .top)
                            
            }

            VStack(alignment: .leading) {
                Button {
                    withAnimation(.spring()) {
                        isShowing.toggle()
                    }
                } label: {
                    Image(systemName: "xmark")
                        .frame(width: 32, height: 32)
                        .foregroundColor(colorScheme == .dark ? .white : .black) // 根据颜色模式选择颜色
                        .padding()
                }

                Image("")
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(width: 120, height: 80)
                
                Spacer()
                
                HStack(spacing: 12) {
                    Text("歡迎您加入")
                        .foregroundColor(colorScheme == .dark ? .white : .black) // 根据颜色模式选择颜色
                        .font(.system(size: 24, weight: .semibold))
                    Spacer()
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct sideMenuHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        sideMenuHeaderView(isShowing: .constant(true))
    }
}
