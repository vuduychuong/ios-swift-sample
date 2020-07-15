//
//  UIImage+QR.swift
//  MetaID_real
//
//  Created by hanjinsik on 30/01/2019.
//  Copyright © 2019 metadium. All rights reserved.
//

extension UIImage {
    func parseQR() -> [String] {
        guard let image = CIImage(image: self) else {
            return []
        }
        
        let detector = CIDetector(ofType: CIDetectorTypeQRCode,
                                  context: nil,
                                  options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])
        
        let features = detector?.features(in: image) ?? []
        
        return features.compactMap { feature in
            return (feature as? CIQRCodeFeature)?.messageString
        }
    }
}
