//
//  SideMenuViewModel.swift
//  worshipHelper
//
//  Created by BBOB on 2024/8/16.
//

import Foundation
import UIKit

enum sideMenuViewModel: Int, CaseIterable {
    case home
    case contact
    case gallery
    case about
    case login
    case logout
    case share
   
    var title: String {
        switch self {
        case .home: return "主頁"
        case .contact: return "連接"
        case .gallery: return "圖庫"
        case .about: return "關於"
        case .login: return "登入"
        case .logout: return "登出"
        case .share: return "分享"
        }
    }
    var imageName: String {
        switch self {
        case .home: return "house.fill"
        case .contact: return "arrow.triangle.2.circlepath.circle.fill"
        case .gallery: return "photo.artframe"
        case .about: return "person.circle"
        case .login: return "arrow.right.square"
        case .logout: return "arrow.left.square"
        case .share: return "square.and.arrow.up"
        }
    }
    
}
