//
//  LoadingView.swift
//  TaiwanTour
//
//  Created by BBOB on 2024/8/18.
//

import SwiftUI

struct LoadingView: View {
    @Binding var isLoading: Bool

    var body: some View {
        ZStack {
            // 背景圖片
            Image("LoadingMainPhoto") // 替換為你的圖片名稱
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            // 加載動畫
//            GIFView() // 確保你的 GIFView 正確顯示 GIF
//                .frame(width: 100, height: 100) // 設置你的 GIF 顯示大小
        }
        .onAppear {
            // 模擬加載，3秒後進入主頁面
            DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                isLoading = false
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(isLoading: .constant(true)) // 使用 .constant(true) 來提供預覽的綁定值
    }
}
