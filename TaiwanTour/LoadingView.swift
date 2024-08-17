//
//  LoadingView.swift
//  TaiwanTour
//
//  Created by BBOB on 2024/8/18.
//

import Foundation
import SwiftUI

struct LoadingView: View {
    @Binding var isLoading: Bool

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            GIFView()
                .frame(width: 10, height: 10) // 設置你的 GIF 顯示大小
        }
        .onAppear {
            // 模擬加載，3秒後進入主頁面
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isLoading = false
            }
        }
    }
}
