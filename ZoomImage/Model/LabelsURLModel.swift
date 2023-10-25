import Foundation
import UIKit

protocol LabelsURLsDownloadable {
    var currentLabel: String { get }
    var currentImageUrl: URL { get }
    mutating func nextLabelURL()
    func downloadImage(completion: @escaping (UIImage?) -> Void)
}

struct GreetingModel: LabelsURLsDownloadable {

    private let label: [String] = ["Привет", "Hello", "Bonjour", "Hola", "Ciao"]
    private let imageUrls: [URL] = [
        URL(string: "https://images2.alphacoders.com/576/576627.jpg")!,
        URL(string: "https://wallpaperaccess.com/full/7316.jpg")!,
        URL(string: "https://images.hdqwalls.com/wallpapers/dota-2-templar-assassin-cosmetic-set-4k-mg.jpg")!
    ]
    private var currentIndex: Int = 0
    private var currentImageIndex: Int = 0

    var currentLabel: String {
        return label[currentIndex]
    }

    var currentImageUrl: URL {
        return imageUrls[currentImageIndex]
    }

    mutating func nextLabelURL() {
        currentIndex = (currentIndex + 1) % label.count
        currentImageIndex = (currentImageIndex + 1) % imageUrls.count
    }

    func downloadImage(completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: URLRequest(url: currentImageUrl, timeoutInterval: 10.0)) { data, _, _ in
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
