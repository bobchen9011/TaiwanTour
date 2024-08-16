//
//  ContentView.swift
//  worshipHelper
//
//  Created by BBOB on 2024/8/16.
//

import SwiftUI
import RiveRuntime

struct ContentView: View {
    @State private var isShowing = false
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    VStack {
                        LinearGradient(
                            gradient: Gradient(colors: [ Color(hex: "008080"), ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 150)
                        .ignoresSafeArea(edges: .top)
                    }
                    
                    Spacer()
                }
                
                if isShowing {
                    sideMenuView(isShowing: $isShowing)
                }
                
                BottomTabView()
                    .cornerRadius(isShowing ? 20 : 10)
                    .offset(x: isShowing ? 300 : 0, y: isShowing ? 44 : 0)
                    .scaleEffect(isShowing ? 0.9 : 1)
                    .navigationBarItems(
                        leading: Button(action: {
                            withAnimation(.spring()) {
                                isShowing.toggle()
                            }
                        }) {
                            Image(systemName: "list.bullet")
                                .foregroundColor(.black)
                        },
                        trailing: Button(action: {
                            // 不再切換暗黑模式
                        }) {
                            // 這裡可以加入按鈕內容
                        }
                    )
                    .navigationTitle("首頁")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct HomeView: View {
    var body: some View {
        VStack(alignment: .center) {
            Text("Welcome to Taiwan Tour APP")
                .customFont(.headline, size: 24) // 使用自定義字型
                .foregroundColor(.black) // 設定文字顏色
        }
        .ignoresSafeArea()
        .background(Color.white) // 設定背景顏色
    }
}

extension Text {
    enum CustomFont: String {
        case headline = "HelveticaNeue-Bold"
        // 定義其他自定義字型
    }
    
    func customFont(_ font: CustomFont, size: CGFloat) -> Text {
        self.font(.custom(font.rawValue, size: size))
    }
    
    func customFont(_ font: CustomFont) -> Text {
        customFont(font, size: 16)
    }
}
