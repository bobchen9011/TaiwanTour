//
//  BottomTabView.swift
//  worshipHelper
//
//  Created by BBOB on 2024/8/16.
//

import SwiftUI
import MapKit

struct BottomTabView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 25.0330, longitude: 121.5654),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
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
            
            RealMapView(region: $region)
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
        .onAppear() {
            UITabBar.appearance().backgroundColor = UIColor(Color(hex: "8e7cc3"))
        }
//        .tint(Color(hex: "674ea7"))
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

struct ItineraryView: View {
    var body: some View {
        Text("這是行程頁面")
    }
}

struct MyPageView: View {
    var body: some View {
        UserAccountView()
    }
}

struct BottomTabView_Previews: PreviewProvider {
    static var previews: some View {
        BottomTabView()
    }
}
