//
//  SideMenuView.swift
//  worshipHelper
//
//  Created by BBOB on 2024/8/16.
//

import SwiftUI

struct sideMenuView: View {
    @Binding var isShowing: Bool
    @AppStorage("isDarkModeOn") var isDarkModeOn: Bool = false // 存储暗黑模式设置
    @Environment(\.colorScheme) var colorScheme // 观察暗黑模式
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false


       init(isShowing: Binding<Bool>) {
           _isShowing = isShowing
           UITableView.appearance().backgroundColor = UIColor(Color.clear) // 设置侧边栏的背景颜色为透明
       }
    let brightModeBackgroundColor = Color.white
       // 在暗黑模式下的背景颜色
    let darkModeBackgroundColor = Color.black
    var body: some View {
        ZStack {
            LinearGradient(
                        gradient: Gradient(colors: [colorScheme == .dark ? darkModeBackgroundColor : brightModeBackgroundColor, colorScheme == .dark ? darkModeBackgroundColor : brightModeBackgroundColor]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .ignoresSafeArea()
            
            VStack {
                sideMenuHeaderView(isShowing: $isShowing)//秀出側邊上面選單
                    .frame(height: 180)
                
                
//                        NavigationLink(destination: {
//                            productSeclectView()                                      //主頁面跳轉到產品選擇頁面
//                        }) {
//                            HStack(spacing: 16) {
//                                Image(systemName: "house.fill")
//                                    .frame(width: 24, height: 24)
//                                    .foregroundColor(colorScheme == .dark ? .white : .black)
//                                Text("產品選擇")
//                                    .font(.system(size: 15, weight: .semibold))
//                                    .foregroundColor(colorScheme == .dark ? .white : .black)
//                                Spacer()
//                            }
//                            .foregroundColor(.black)
//                            .padding()
//                        }
                
//                NavigationLink(destination: {           //挑轉到藍芽連接頁面
//                    blueToothView()
//                }) {
//                    HStack(spacing: 16) {
//                        Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
//                            .frame(width: 24, height: 24)
//                            .foregroundColor(colorScheme == .dark ? .white : .black)
//                        Text("藍芽連接")
//                            .font(.system(size: 15, weight: .semibold))
//                            .foregroundColor(colorScheme == .dark ? .white : .black)
//                        Spacer()
//                    }
//                    .foregroundColor(.black)
//                    .padding()
//                }
//                    NavigationLink(destination: {           //跳轉到用戶體驗頁面
//                        experiView()
//                    }) {
//                        HStack(spacing: 16) {
//                            Image(systemName: "photo.artframe")
//                                .frame(width: 24, height: 24)
//                                .foregroundColor(colorScheme == .dark ? .white : .black)
//                            Text("狀態紀錄")
//                                .font(.system(size: 15, weight: .semibold))
//                                .foregroundColor(colorScheme == .dark ? .white : .black)
//                            Spacer()
//                        }
//                        .foregroundColor(.black)
//                        .padding()
//                    }
                
//                NavigationLink(destination: {
//                    SocialShareView()
//                }) {
//                    HStack(spacing: 16) {
//                        Image(systemName: "square.and.arrow.up")
//                            .frame(width: 24, height: 24)
//                            .foregroundColor(colorScheme == .dark ? .white : .black)
//                        Text("分享")
//                            .font(.system(size: 15, weight: .semibold))
//                            .foregroundColor(colorScheme == .dark ? .white : .black)
//                        Spacer()
//                    }
//                    .foregroundColor(.black)
//                    .padding()
//                }
                
//                NavigationLink(destination: {           //跳轉到登入,創建帳號頁面
//                    ///smsLogin()
//                }) {
//                    HStack(spacing: 16) {
//                        Image(systemName: "bubble.left.circle")
//                            .frame(width: 24, height: 24)
//                            .foregroundColor(colorScheme == .dark ? .white : .black)
//                        Text("sms登入")
//                            .font(.system(size: 15, weight: .semibold))
//                            .foregroundColor(colorScheme == .dark ? .white : .black)
//                        Spacer()
//                    }
//                    .foregroundColor(.black)
//                    .padding()
//                }
                NavigationLink(destination: {           //跳轉到用戶資料頁面
                }) {
                    HStack(spacing: 16) {
                        Image(systemName: "photo.artframe")
                            .frame(width: 24, height: 24)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        Text("用戶身體狀態")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        Spacer()
                    }
                    .foregroundColor(.black)
                    .padding()
                    
                }
                if isLoggedIn {
                    Button(action: { isLoggedIn = false }) {
                        HStack(spacing: 16) {
                            Image(systemName: "arrow.left.square")
                                .frame(width: 24, height: 24)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                            Text("登出")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                            Spacer()
                        }
                        .foregroundColor(.black)
                        .padding()
                    }
                }
                
                
                NavigationLink(destination: {           //跳轉到用戶資料頁面
                    
                }) {
                    HStack(spacing: 16) {
                        Image(systemName: "person.circle")
                            .frame(width: 24, height: 24)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        Text("關於App")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        Spacer()
                    }
                    .foregroundColor(.black)
                    .padding()
                    
                }
                Spacer()
            }
        }
        .navigationBarHidden(true)
        .preferredColorScheme(colorScheme) // 手动设置颜色方案，确保侧边栏也跟随变化
    }
}

struct sideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        sideMenuView(isShowing: .constant(false))       //側邊頁面 不持續顯示
    }
}
