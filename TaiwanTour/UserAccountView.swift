//
//  UserAccount.swift
//  TaiwanTour
//
//  Created by BBOB on 2024/8/26.
//

import SwiftUI

struct UserAccountView: View {
    @State private var mail = ""
    @State private var password = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                // 用戶頭像
                HStack {
                    Spacer()
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                    Spacer()
                }
                .padding(.bottom)

                // 標題
                Text("登入")
                    .font(.title3)
                    .padding(.bottom, 20)
                
                // 輸入框
                VStack(spacing: 16) {
                    VStack(alignment: .leading) {
                        TextField("信箱", text: $mail)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.leading, 8)
                    }
                    
                    Divider()

                    VStack(alignment: .leading) {
                        SecureField("密碼", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.leading, 8)
                    }
                    
                    Divider()
                }
                .padding(.horizontal, 20)
                
                // 登入按鈕
                Button(action: {
                    // 登入動作
                }) {
                    Text("登入")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "674ea7"))
                        .foregroundColor(.white)
                        .cornerRadius(50)
                        .padding(.horizontal, 20)
                }
                
                // 創建帳號按鈕
                Button(action: {
                    // 創建帳號動作
                }) {
                    Text("創建帳號")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "8e7cc3"))
                        .foregroundColor(.white)
                        .cornerRadius(50)
                        .padding(.horizontal, 20)
                }
                
                // 分隔線和文字
                HStack {
                    Rectangle()
                        .frame(height: 1)
                        .opacity(0.1)
                    Text("或")
                    Rectangle()
                        .frame(height: 1)
                        .opacity(0.1)
                }
                .padding(.horizontal, 20)

                // 第三方登入選項
                HStack {
                    Spacer()
                    Button(action: {
                        // Apple 登入動作
                    }) {
                        Image("Logo Apple")
                            .resizable()
                            .frame(width: 70, height: 70)
                    }
                    Spacer()
                    Button(action: {
                        // Google 登入動作
                    }) {
                        Image("Logo Google")
                            .resizable()
                            .frame(width: 70, height: 70)
                    }
                    Spacer()
                    Button(action: {
                        // Email 登入動作
                    }) {
                        Image("Logo Email")
                            .resizable()
                            .frame(width: 70, height: 70)
                    }
                    Spacer()
                }
                .padding(.bottom, 20)

                Spacer()

                // 版本號
                Text("Ver 1.0.0")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            .navigationTitle("用戶帳號")
            .background(Color(.systemBackground))
        }
    }
}

struct UserAccountView_Previews: PreviewProvider {
    static var previews: some View {
        UserAccountView()
    }
}
