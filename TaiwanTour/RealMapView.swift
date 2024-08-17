//
//  RealMapView.swift
//  TaiwanTour
//
//  Created by BBOB on 2024/8/17.
//

import SwiftUI
import MapKit

struct RealMapView: View {
    @Binding var region: MKCoordinateRegion
    @State private var searchText: String = ""
    @State private var searchResults: [MKPlacemark] = []

    var body: some View {
        VStack {
            TextField("搜尋地點", text: $searchText, onCommit: {
                searchPlaces()
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            
            MapView(region: $region)
                .edgesIgnoringSafeArea(.all)
        }
        .onChange(of: searchText) { newValue in
            searchPlaces()
        }
    }
    
    private func searchPlaces() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            if let error = error {
                print("Error during search: \(error.localizedDescription)")
                return
            }
            
            guard let response = response else { return }
            searchResults = response.mapItems.map { $0.placemark }
            if let firstResult = searchResults.first {
                region = MKCoordinateRegion(
                    center: firstResult.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                )
            }
        }

    }
}

extension UIApplication {
    func endEditing(_ force: Bool) {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
