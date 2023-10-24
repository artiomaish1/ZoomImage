import Foundation
import UIKit

protocol ImageModelabel {
    func getImage (_ completion: @escaping ((UIImage?) -> Void))
}

struct ImageModel: ImageModelabel {
    private let imageUrl: URL

    init(imageUrl: URL) {
        self.imageUrl = imageUrl
    }

    func getImage(_ completion: @escaping((UIImage?) -> Void)) {
        URLSession.shared.dataTask(with: URLRequest(url: imageUrl, timeoutInterval: 1.0)) { data, _, _ in
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    completion(image)
                } else {
                    completion(nil)
                }
            }
        }.resume()
    }
}
