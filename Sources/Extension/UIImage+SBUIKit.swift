//
//  UIImage+SBUIKit.swift
//  SendbirdUIKit
//
//  Created by Tez Park on 16/02/2020.
//  Copyright © 2020 Sendbird, Inc. All rights reserved.
//
// swiftlint:disable identifier_name

import UIKit

// MARK: - Public extension
public extension UIImage {
    /// This applies the tint color to the `UIImage`.
    /// - Parameter tintColor: tint color
    /// - Returns: `Uiimage` objects with tint color
    func sbu_with(tintColor: UIColor?) -> UIImage {
        guard let tintColor = tintColor else { return self }
        if #available(iOS 13.0, *) {
            return withTintColor(tintColor)
        } else {
            let image = self
            UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
            tintColor.setFill()
            let context = UIGraphicsGetCurrentContext()
            context?.translateBy(x: 0, y: image.size.height)
            context?.scaleBy(x: 1.0, y: -1.0)
            context?.setBlendMode(CGBlendMode.normal)
            let rect = CGRect(
                origin: .zero,
                size: CGSize(width: image.size.width, height: image.size.height)
            )
            context?.clip(to: rect, mask: image.cgImage!)
            context?.fill(rect)
            
            guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {
                return self
            }
            
            UIGraphicsEndImageContext()
            
            return newImage
        }
    }
    
    /// This applies the tint color to the `UIImage` with `forTemplate` option.
    /// - Parameters:
    ///   - tintColor: tint color
    ///   - forTemplate: If this option is `true`, the Blend mode of tint color will be applied to `sourceAtop` after `colorBurn`.
    /// - Returns: `UIImage` objects with tint color
    /// - Since: 3.5.4
    func sbu_with(tintColor: UIColor?, forTemplate: Bool) -> UIImage {
        if !forTemplate {
            return self.sbu_with(tintColor: tintColor)
        }
        
        guard let tintColor = tintColor else { return self }
        defer { UIGraphicsEndImageContext() }
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        if let context = UIGraphicsGetCurrentContext() {
            tintColor.setFill()
            
            context.translateBy(x: 0, y: self.size.height)
            context.scaleBy(x: 1.0, y: -1.0)
            
            context.setBlendMode(CGBlendMode.colorBurn)
            let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
            if let cgImage = self.cgImage {
                context.draw(cgImage, in: rect)
                
                context.setBlendMode(CGBlendMode.sourceAtop)
                context.addRect(rect)
                context.drawPath(using: CGPathDrawingMode.fill)
                
                if let coloredImage = UIGraphicsGetImageFromCurrentImageContext() {
                    return coloredImage
                }
            }
        }
        return self
    }
    
    /// Converts image to data.
    ///
    /// - Note: If the `SBUGlobals.isImageCompressionEnabled` is `true`, the image will be resized with `SBUGlobals.imageResizingSize` and compressed with `SBUGlobals.imageCompressionRate`.
    /// - Returns: Image Data
    ///
    /// - Since: 3.3.1
    func sbu_convertToData() -> Data? {
        var image = self
        if SBUGlobals.isImageCompressionEnabled {
            image = self.resize(with: SBUGlobals.imageResizingSize)
        }
        
        let data = image.jpegData(
            compressionQuality: SBUGlobals.isImageCompressionEnabled
            ? SBUGlobals.imageCompressionRate
            : 1.0
        )
        
        if data == nil {
            SBULog.error("No image data")
        }
        
        return data
    }
    
    /// Resizes the image to the target size.
    /// - Since: 3.22.0
    func sbu_resize(with targetSize: CGSize) -> UIImage {
        self.resize(with: targetSize)
    }
    
    /// Creates an image with a background color, optional margin, and circular clipping.
    ///
    /// This method draws the current image onto a background of the specified color. If `circle` is true, the image will be clipped to a circular shape. A margin can be added around the image.
    ///
    /// - Parameters:
    ///   - color: The background color.
    ///   - margin: The margin around the image. Defaults to 0 if not specified.
    ///   - circle: A Boolean value that determines whether the image should be clipped to a circle. Defaults to false.
    /// - Returns: A new image with the background color, optional margin, and circular clipping if specified.
    ///
    /// - Since: 3.22.0
    func sbu_withBackground(color: UIColor, margin: CGFloat, circle: Bool = false) -> UIImage {
        self.withBackground(color: color, margin: margin, circle: circle)
    }

    /// Creates an image entirely filled with the specified color.
    ///
    /// This method generates a 1x1 pixel image and scales it to fill the entire view, effectively creating a solid color image. This can be useful for creating placeholder images, backgrounds, or any other elements where a solid color image is required.
    ///
    /// - Parameter color: The color to fill the image with.
    /// - Returns: A `UIImage` object filled with the specified color.
    /// 
    /// - Since: 3.22.0
    static func sbu_from(color: UIColor) -> UIImage {
        UIImage.from(color: color)
    }
}

// MARK: - Private extension
extension UIImage {
    static func from(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        guard let context = UIGraphicsGetCurrentContext() else { return UIImage() }
        context.setFillColor(color.cgColor)
        context.fill(rect)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        UIGraphicsEndImageContext()
        return image
    }
    
    func resize(with targetSize: CGSize) -> UIImage {
        let size = self.size
        var scale = 1.0
        
        if size.width <= targetSize.width && size.height <= targetSize.height {
            
        } else if size.width > targetSize.width && size.height <= targetSize.height {
            scale = targetSize.width / size.width
        } else if size.width <= targetSize.width && size.height > targetSize.height {
            scale = targetSize.height / size.height
        } else if size.width > targetSize.width && size.height > targetSize.height {
            let widthRatio = targetSize.width / size.width
            let heightRatio = targetSize.height / size.height
            scale = min(widthRatio, heightRatio)
        }
        
        let scaledImageSize = CGSize(
            width: size.width * scale,
            height: size.height * scale
        )
        let renderer = UIGraphicsImageRenderer(size: scaledImageSize)
        
        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: scaledImageSize))
        }
        
        return scaledImage
    }
    
    convenience init(url: URL) {
        self.init()
        DispatchQueue.global().async { [weak self] in
            if self == nil { return }
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self = image as? Self
                    }
                }
            }
        }
    }
    
    func isAnimatedImage() -> Bool {
        return self.images?.count ?? 0 > 1
    }

    func fixedOrientation() -> UIImage {
        switch self.imageOrientation {
        case .up:
            return self
        default:
            UIGraphicsBeginImageContextWithOptions(size, false, scale)
            let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            self.draw(in: rect)

            let normalizedImage = UIGraphicsGetImageFromCurrentImageContext() ?? self
            UIGraphicsEndImageContext()
            return normalizedImage
        }
    }
    
    func withBackground(color: UIColor, margin: CGFloat, circle: Bool = false) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        
        guard let context = UIGraphicsGetCurrentContext(), let image = cgImage else { return self }
        defer { UIGraphicsEndImageContext() }
        
        let backgroundRect = CGRect(origin: .zero, size: size)
        context.setFillColor(color.cgColor)

        if circle {
            let radiusSize = min(size.width, size.height)
            let clipPath = UIBezierPath(roundedRect: backgroundRect, cornerRadius: radiusSize/2).cgPath
            context.addPath(clipPath)
            context.closePath()
            context.fillPath()
        } else {
            context.fill(backgroundRect)
        }
        context.concatenate(CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: size.height))

        let imageRect = CGRect(
            origin: .init(x: margin, y: margin),
            size: .init(width: self.size.width - margin*2, height: self.size.height - margin*2)
        )
        context.draw(image, in: imageRect)
        
        return UIGraphicsGetImageFromCurrentImageContext() ?? self
    }
    
    class func createImage(from data: Data) -> UIImage? {
        if let source = CGImageSourceCreateWithData(data as CFData, nil),
           CGImageSourceGetCount(source) > 1 {
            // Animated image
            return UIImage.animatedImageWithSource(source)
        } else {
            // Singe image
            return UIImage(data: data)
        }
    }
}

// MARK: - GIF image handling (figuring out gif delays)
/// Note: https://github.com/kiritmodi2702/GIF-Swift/blob/master/GIF-Swift/iOSDevCenters%2BGIF.swift
extension UIImage {
    internal class func delayForImageAtIndex(_ index: Int, source: CGImageSource?) -> Float {
        guard let source = source else { return 0 }
        guard let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil) else { return 0 }
        guard let gifProperties = (cfProperties as NSDictionary)[kCGImagePropertyGIFDictionary as String] as? NSDictionary else { return 0 }
         
        var clampedDelayTime = Float.zero
        var unclampedDelayTime = Float.zero
        
        if let delayTime = gifProperties[kCGImagePropertyGIFDelayTime as String] as? NSNumber {
            clampedDelayTime = delayTime.floatValue
        }
        
        if let delayTime = gifProperties[kCGImagePropertyGIFUnclampedDelayTime as String] as? NSNumber {
            unclampedDelayTime = delayTime.floatValue
        }
        
        return max(clampedDelayTime, unclampedDelayTime)
    }
    
    /// Greatest common divisor
    internal class func gcdForPair(_ a: Int, _ b: Int) -> Int {
        var a = a
        var b = b
        
        if a < b { swap(&a, &b) }
        b = b != 0 ? b : 1
        while true {
            guard b != 0 else { return a == 0 ? 1 : a }
            guard a % b > 0 else { return b }
            let temp = a
            a = b
            b = temp % b
        }
    }
    
    internal class func gcdForArray(_ array: [Int]) -> Int {
        guard var gcd = array.first else { return 1 }
        array.forEach { gcd = UIImage.gcdForPair($0, gcd) }
        return gcd
    }
    
    internal class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()
        
        (0..<count).forEach {
            if let image = CGImageSourceCreateImageAtIndex(source, $0, nil) {
                images.append(image)
            }
            
            let delaySeconds = UIImage.delayForImageAtIndex($0, source: source)
            
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }
        
        let duration = delays.reduce(0, +)
        
        let gcd = gcdForArray(delays)
        
        var frames: [UIImage] = []
        (0..<count).forEach {
            let frame = UIImage(cgImage: images[$0])
            let frameCount = gcd == 0 ? 0 : Int(delays[$0] / gcd)
            frames.append(contentsOf: [UIImage](repeating: frame, count: frameCount))
        }
        
        let animation = UIImage.animatedImage(
            with: frames,
            duration: Double(duration) / 1000.0
        )
        
        return animation
    }
}
// swiftlint:enable identifier_name

extension UIImage {
    static var sbu_imageDownloader = SBUImageDownloader()
}

// 이미지 다운로드 클래스 정의
class SBUImageDownloader {
    func url(string: String) -> URL? {
        URL(string: string)
    }
    
    func image(url: URL) -> UIImage? {
        UIImage(url: url)
    }
    
    func downloadImage(
        from url: URL,
        completion: @escaping (Data?, Error?) -> Void
    ) -> URLSessionDataTask? {
        URLSession(configuration: .default).dataTask(with: url) { data, _, error in
            completion(data, error)
        }
    }
}
