//
//  GIFView.swift
//  TaiwanTour
//
//  Created by BBOB on 2024/8/18.
//

import Foundation
import SwiftUI
import UIKit

struct GIFView: UIViewRepresentable {
    private let imageView = UIImageView()

    func makeUIView(context: Context) -> UIImageView {
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }

    func updateUIView(_ uiView: UIImageView, context: Context) {
        if let gifImage = UIImage.gif(name: "loading") {
            uiView.image = gifImage
        }
    }
}

