//
//  ImageLoader.swift
//  Astra
//
//  Created by Andrey Chernyshev on 21.08.2021.
//

import Kingfisher

final class ImageLoader {
    static func setup(in imageView: UIImageView, imageUrl: String, orientation: UIImage.Orientation? = nil) {
        imageView.kf.cancelDownloadTask()
        
        guard let url = URL(string: imageUrl) else {
            return
        }
        
        KingfisherManager.shared.retrieveImage(with: url) { result in
            guard let cgImage = try? result.get().image.cgImage else {
                return
            }
            
            let resultImage: UIImage
            
            if let orientation = orientation {
                resultImage = UIImage(cgImage: cgImage, scale: 1, orientation: orientation)
            } else {
                resultImage = UIImage(cgImage: cgImage)
            }
            
            imageView.image = resultImage
        }
    }
}
