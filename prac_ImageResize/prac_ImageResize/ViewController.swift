//
//  ViewController.swift
//  prac_ImageResize
//
//  Created by 남수김 on 2021/05/28.
//

import UIKit
import ImageIO

class ViewController: UIViewController {
    private let image_6mb = "sample1"
    private let image_9mb = "sample2"
    private let image_scale = "image"
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    private func resizeImage(_ image: UIImage?) -> UIImage? {
//        return image?.resize(newWidth: imageView.frame.width)
//        return image?.downSample(scale: 0.1)
        return image?.downSample(size: imageView.frame.size)
    }
    
    @IBAction func segmentTap(_ sender: UISegmentedControl) {
        var image: UIImage?
        switch sender.selectedSegmentIndex {
        case 0:
            image = UIImage(named: image_6mb)
        case 1:
            image = UIImage(named: image_9mb)
        case 2:
            image = UIImage(named: image_scale)
        default:
            return
        }
        imageView.image = resizeImage(image)
//        imageView.image = image
    }
    
    @IBAction func resizeTap(_ sender: Any) {
        let newImage = imageView.image?.resize(newWidth: imageView.frame.width)
        imageView.image = newImage
    }
}

extension UIImage {
    func resize(newWidth: CGFloat) -> UIImage {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale

        let size = CGSize(width: newWidth, height: newHeight)
        let render = UIGraphicsImageRenderer(size: size)
        let renderImage = render.image { context in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
        
        print("화면 배율: \(UIScreen.main.scale)")// 배수
        print("origin: \(self)\n resize: \(renderImage)")
        printDataSize(renderImage)
        return renderImage
    }
    
    func downSample(scale: CGFloat) -> UIImage {
        let imageSourceOption = [kCGImageSourceShouldCache: false] as CFDictionary
        let data = self.pngData()! as CFData
        let imageSource = CGImageSourceCreateWithData(data, imageSourceOption)!
        let maxPixel = max(self.size.width, self.size.height) * scale
        let downSampleOptions = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxPixel
        ] as CFDictionary
        
        let downSampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downSampleOptions)!
        
        let newImage = UIImage(cgImage: downSampledImage)
        printDataSize(newImage)
        return newImage
    }
    
    func downSample(size: CGSize, scale: CGFloat = UIScreen.main.scale) -> UIImage {
        let imageSourceOption = [kCGImageSourceShouldCache: false] as CFDictionary
        let data = self.pngData()! as CFData
        let imageSource = CGImageSourceCreateWithData(data, imageSourceOption)!
        
        let maxPixel = max(size.width, size.height) * scale
        let downSampleOptions = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxPixel
        ] as CFDictionary
        
        let downSampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downSampleOptions)!
        
        let newImage = UIImage(cgImage: downSampledImage)
        printDataSize(newImage)
        return newImage
    }
    
    private func printDataSize(_ resize: UIImage) {
        print("originData: \(self.pngData()!)\n resizeData: \(resize.pngData()!)")
    }
}
