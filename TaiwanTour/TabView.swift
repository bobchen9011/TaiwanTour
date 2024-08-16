//
//  BottomTabView.swift
//  worshipHelper
//
//  Created by BBOB on 2024/8/16.
//

import Foundation
import SwiftUI

struct BottomTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("首頁")
                }
            
            AccommodationView()
                .tabItem {
                    Image(systemName: "bed.double.fill")
                    Text("住宿")
                }
            
            MapView()
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("地圖")
                }
            
            ItineraryView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("行程")
                }
            
            MyPageView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("我的")
                }
        }
        
    }
}

struct HomePageView: View {
    var body: some View {
        Text("這是首頁")
    }
}

struct AccommodationView: View {
    var body: some View {
        Text("這是住宿頁面")
    }
}

struct MapView: View {
    var body: some View {
        Text("這是地圖頁面")
    }
}

struct ItineraryView: View {
    var body: some View {
        Text("這是行程頁面")
    }
}

struct MyPageView: View {
    var body: some View {
        Text("這是我的頁面")
    }
}

struct BottomTabView_Previews: PreviewProvider {
    static var previews: some View {
        BottomTabView()
    }
}

