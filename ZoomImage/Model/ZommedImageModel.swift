import Foundation
import UIKit

protocol ImageModelabel {
    func getImage (_ completion: @escaping ((UIImage?) -> Void))
}

struct ImageModel: ImageModelabel {
    private let imageUrl: URL?
    
    init(imageUrl: URL?) {
        self.imageUrl = imageUrl
    }
    
    func getImage(_ completion: @escaping((UIImage?) -> Void)) {
        if let imageUrl {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageUrl), let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        completion(image)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
        } else {
            completion(nil)
        }
    }
}

