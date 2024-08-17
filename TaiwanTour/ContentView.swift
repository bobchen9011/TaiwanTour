//
//  ContentView.swift
//  worshipHelper
//
//  Created by BBOB on 2024/8/16.
//

import SwiftUI
import CoreLocation
import RiveRuntime

struct ContentView: View {
    @StateObject private var locationManager = LocationManager() // 距離計算
    @State private var isShowing = false
    @State private var isLoading = true // 用於控制是否顯示加載動畫
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            if isLoading {
                LoadingView(isLoading: $isLoading)
            } else {
                NavigationView {
                    ZStack {
                        VStack {
                            VStack {
                                LinearGradient(
                                    gradient: Gradient(colors: [Color(hex: "008080")]),
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


// LocationManager 類別
class LocationManager1: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var userLocation: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.userLocation = location
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    
    func distance(from location: CLLocation) -> Double? {
        guard let userLocation = userLocation else { return nil }
        return userLocation.distance(from: location) / 1000 // 距離轉換為公里
    }
}

// HomeView 加入距離計算
struct HomeView: View {
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                // 輪播圖
                CarouselView(images: ["taipei101", "sunMoonLake", "alishan"])
                    .frame(height: 200)
                    .padding(.bottom, 20)
                
                // 搜索欄位
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("搜尋景點、餐廳或活動", text: .constant(""))
                        .padding(.leading, 5)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
                
                // 推薦景點
                Text("推薦景點")
                    .font(.title2)
                    .bold()
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(recommendedDestinations) { destination in
                            DestinationCard(destination: destination)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 20)
                
                // 附近景點
                Text("附近景點")
                    .font(.title2)
                    .bold()
                    .padding(.horizontal)
                
                ForEach(nearbyDestinations.sorted(by: { destination1, destination2 in
                    let location1 = CLLocation(latitude: destination1.latitude, longitude: destination1.longitude)
                    let location2 = CLLocation(latitude: destination2.latitude, longitude: destination2.longitude)
                    
                    let distance1 = locationManager.distance(from: location1) ?? 0
                    let distance2 = locationManager.distance(from: location2) ?? 0
                    
                    return distance1 < distance2
                })) { destination in
                    if let distance = locationManager.distance(from: CLLocation(latitude: destination.latitude, longitude: destination.longitude)) {
                        NearbyDestinationCard(destination: destination, distance: distance)
                            .onTapGesture {
                                if let url = URL(string: "https://www.google.com/maps/dir/?api=1&destination=\(destination.latitude),\(destination.longitude)") {
                                    UIApplication.shared.open(url)
                                }
                            }
                    } else {
                        Text("位置資訊尚在更新中...")
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("旅遊導覽")
        }
    }
}

// 輪播圖 View
struct CarouselView: View {
    let images: [String]
    @State private var currentIndex = 0
    
    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(0..<images.count, id: \.self) { index in
                Image(images[index])
                    .resizable()
                    .scaledToFill()
                    .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(height: 200)
    }
}

// 景點卡片
struct DestinationCard: View {
    let destination: Destination
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(destination.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 100)
                .clipped()
                .cornerRadius(8)
            
            Text(destination.name)
                .font(.headline)
                .lineLimit(1)
                .padding(.top, 5)
            
            Text(destination.description)
                .font(.subheadline)
                .foregroundColor(.gray)
                .lineLimit(2)
        }
        .frame(width: 150)
    }
}

// 附近景點卡片
struct NearbyDestinationCard: View {
    let destination: Destination
    let distance: Double
    
    var body: some View {
        HStack {
            Image(destination.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipped()
                .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text(destination.name)
                    .font(.headline)
                
                Text(String(format: "%.2f 公里", distance))
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text(destination.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
            }
            .padding(.leading, 10)
        }
        .padding(.vertical, 10)
    }
}

// 景點資料模型
struct Destination: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let imageName: String
    let latitude: Double
    let longitude: Double
}

// 測試資料
let recommendedDestinations = [
    Destination(name: "台北101", description: "城市地標的美景", imageName: "taipei101", latitude: 25.033964, longitude: 121.562321),
    Destination(name: "日月潭", description: "台灣最美的湖泊", imageName: "sunMoonLake", latitude: 25.033964, longitude: 121.562321),
    Destination(name: "阿里山", description: "觀賞日出的最佳去處", imageName: "alishan", latitude: 25.033964, longitude: 121.562321),
    Destination(name: "鹿港老街", description: "傳統文化老街", imageName: "lukang", latitude: 24.056951, longitude: 120.435459),
    Destination(name: "九份老街", description: "懷舊與山城結合", imageName: "jiufen", latitude: 25.110392, longitude: 121.843136),
    
]

let nearbyDestinations = [
    Destination(name: "故宮博物院", description: "台灣最大的博物館", imageName: "gugong", latitude: 25.1023554, longitude: 121.5484925),
    Destination(name: "淡水老街", description: "悠閒散步好去處", imageName: "tamsui", latitude: 25.1694929, longitude: 121.4406812),
    Destination(name: "國立自然科學博物館", description: "探索自然科學的好地方", imageName: "naturalScienceMuseum", latitude: 24.144287, longitude: 120.683075),
    Destination(name: "台中公園", description: "悠閒放鬆的綠意空間", imageName: "taichungPark", latitude: 24.141103, longitude: 120.684771),
    Destination(name: "逢甲夜市", description: "台中最熱鬧的夜市之一", imageName: "fengjiaNightMarket", latitude: 24.176664, longitude: 120.647957),
    Destination(name: "草悟道", description: "充滿藝術氛圍的步道", imageName: "calligraphyGreenway", latitude: 24.146457, longitude: 120.681352),
    Destination(name: "彩虹眷村", description: "充滿色彩的藝術村", imageName: "rainbowVillage", latitude: 24.157541, longitude: 120.649679),
    Destination(name: "台北101", description: "台北市的地標與觀景勝地", imageName: "taipei101", latitude: 25.033964, longitude: 121.564472),
    Destination(name: "日月潭", description: "台灣最著名的湖泊景點", imageName: "sunMoonLake", latitude: 23.864405, longitude: 120.915004),
    Destination(name: "阿里山國家風景區", description: "壯觀的山景與森林步道", imageName: "alishan", latitude: 23.508389, longitude: 120.805727),
    Destination(name: "墾丁國家公園", description: "台灣最南端的自然景觀", imageName: "kenting", latitude: 21.949707, longitude: 120.779469),
    Destination(name: "龍磐公園", description: "壯麗的海景與草原", imageName: "longpanPark", latitude: 21.957451, longitude: 120.841711),
    Destination(name: "太魯閣國家公園", description: "台灣東部的峽谷與大理石山脈", imageName: "taroko", latitude: 24.154358, longitude: 121.620999),
    Destination(name: "九份老街", description: "懷舊與山城景觀的結合", imageName: "jiufen", latitude: 25.110392, longitude: 121.843136),
    Destination(name: "野柳地質公園", description: "獨特的岩石景觀與女王頭岩", imageName: "yehliu", latitude: 25.206436, longitude: 121.690947),
    Destination(name: "鹿港老街", description: "古色古香的傳統文化街區", imageName: "lukang", latitude: 24.056951, longitude: 120.435459),
    Destination(name: "金瓜石黃金博物館", description: "台灣礦業歷史與黃金文化的展覽", imageName: "goldMuseum", latitude: 25.109057, longitude: 121.846784),
    Destination(name: "台南孔廟", description: "台灣歷史最悠久的孔子廟", imageName: "tainanConfuciusTemple", latitude: 22.993833, longitude: 120.204012)
]


// 其他頁面的占位符
struct SearchView: View {
    var body: some View {
        Text("搜尋頁面")
    }
}

struct FavoritesView: View {
    var body: some View {
        Text("收藏頁面")
    }
}

struct ProfileView: View {
    var body: some View {
        Text("我的頁面")
    }
}
