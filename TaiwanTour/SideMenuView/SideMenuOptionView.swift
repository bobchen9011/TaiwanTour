//
//  SideMenuOptionView.swift
//  worshipHelper
//
//  Created by BBOB on 2024/8/16.
//

import SwiftUI

struct sideMenuOptionView: View {
    let viewModel: sideMenuViewModel
    @Environment(\.colorScheme) var colorScheme // 观察暗黑模式

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: viewModel.imageName)
                .frame(width: 24, height: 24)
                .foregroundColor(colorScheme == .dark ? .white : .black) // 根据颜色模式选择颜色
            Text(viewModel.title)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(colorScheme == .dark ? .white : .black) // 根据颜色模式选择颜色
            Spacer()
        }
        .padding()
    }
}

struct sideMenuOptionView_Previews: PreviewProvider {
    static var previews: some View {
        sideMenuOptionView(viewModel: .home)
    }
}
