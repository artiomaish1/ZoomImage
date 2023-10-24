import Foundation
import UIKit

protocol GreetingsModelable {
    var currentGreeting: String { get }
    var currentImageUrl: URL { get }
    mutating func nextGreetingURL()
    func downloadImage(completion: @escaping (UIImage?) -> Void)
}

struct GreetingModel: GreetingsModelable {

    private let greetings: [String] = ["Привет", "Hello", "Bonjour", "Hola", "Ciao"]
    private let imageUrls: [URL] = [
        URL(string: "https://images2.alphacoders.com/576/576627.jpg")!,
        URL(string: "https://wallpaperaccess.com/full/7316.jpg")!,
        URL(string: "https://images.hdqwalls.com/wallpapers/dota-2-templar-assassin-cosmetic-set-4k-mg.jpg")!
    ]
    private var currentIndex: Int = 0
    private var currentImageIndex: Int = 0

    var currentGreeting: String {
        return greetings[currentIndex]
    }

    var currentImageUrl: URL {
        return imageUrls[currentImageIndex]
    }

    mutating func nextGreetingURL() {
        currentIndex = (currentIndex + 1) % greetings.count
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

    private func createImageModel() -> ImageModel {
        return ImageModel(imageUrl: currentImageUrl)
    }
}
