//
//  ImageLoaderViewModel.swift
//  DIKIDItest
//
//  Created by Владислав Соколов on 07.04.2025.
//

import UIKit

@MainActor
final class ImageLoaderViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    private let imageApi: ImageApi

    init(imageApi: ImageApi = NetworkImageManager()) {
        self.imageApi = imageApi
    }

    func loadImage(from urlString: String) async {
        guard let url = URL(string: urlString) else { return }

        do {
            let imageData = try await imageApi.fetchImage(from: url)
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        } catch {
            print("Ошибка загрузки изображения: \(error)")
        }
    }
}
