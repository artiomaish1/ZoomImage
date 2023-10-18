import Foundation
import UIKit

protocol GreetingModelDelegate: AnyObject {
    func modelDidUpdateImage(_ image: UIImage)
}

protocol GreetingsModelable {
    var currentGreeting: String { get }
    var currentImageUrl: URL { get }
    mutating func nextGreeting()
    mutating func nextImage()
    func downloadImage(completion: @escaping (UIImage?) -> Void)
    mutating func updateUI(completion: @escaping () -> Void)
    func createImageModel() -> ImageModel
}

struct GreetingModel: GreetingsModelable {

    let greetings: [String] = ["Привет", "Hello", "Bonjour", "Hola", "Ciao"]
    let imageUrls: [URL] = [
        URL(string: "https://images2.alphacoders.com/576/576627.jpg")!,
        URL(string: "https://wallpaperaccess.com/full/7316.jpg")!,
        URL(string: "https://images.hdqwalls.com/wallpapers/dota-2-templar-assassin-cosmetic-set-4k-mg.jpg")!
    ]
    var currentIndex: Int = 0
    var currentImageIndex: Int = 0

    weak var delegate: GreetingModelDelegate?

    var currentGreeting: String {
        return greetings[currentIndex]
    }

    var currentImageUrl: URL {
        return imageUrls[currentImageIndex]
    }

    mutating func nextGreeting() {
        currentIndex = (currentIndex + 1) % greetings.count
        currentImageIndex = (currentImageIndex + 1) % imageUrls.count
    }

    mutating func nextImage() {
        currentImageIndex = (currentImageIndex + 1) % imageUrls.count
    }

    func downloadImage(completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: URLRequest(url: currentImageUrl, timeoutInterval: 10.0)) { data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }

    func updateUI(completion: @escaping () -> Void) {

        let imageUrl = currentImageUrl

        downloadImage(from: imageUrl) { image in
            completion()
            if let image = image {
                self.delegate?.modelDidUpdateImage(image)
            }
        }
    }

    private func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {

        URLSession.shared.dataTask(with: URLRequest(url: url, timeoutInterval: 10.0)) { data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }
    func createImageModel() -> ImageModel {
        return ImageModel(imageUrl: currentImageUrl)
    }
}
