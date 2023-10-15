import Foundation


struct GreetingModel {
    let greetings: [String] = ["Привет", "Hello", "Bonjour", "Hola", "Ciao"]
    let imageUrls: [URL] = [
        URL(string: "https://images2.alphacoders.com/576/576627.jpg")!,
        URL(string: "https://wallpaperaccess.com/full/7316.jpg")!,
        URL(string: "https://images.hdqwalls.com/wallpapers/dota-2-templar-assassin-cosmetic-set-4k-mg.jpg")!
    ]
    
    var currentIndex: Int = 0
    var currentImageIndex: Int = 0
    
    var imageModel: ImageModel {
        return ImageModel(imageUrl: imageUrls[currentImageIndex])
    }
}

protocol GreetingsModelable {
    mutating func nextGreeting()
    func currentGreeting() -> String
    func currentImageUrl() -> URL
}

extension GreetingModel: GreetingsModelable {
    mutating func nextGreeting() {
        currentIndex = (currentIndex + 1) % greetings.count
        currentImageIndex = (currentImageIndex + 1) % imageUrls.count
    }
    
    func currentGreeting() -> String {
        return greetings[currentIndex]
    }
    
    func currentImageUrl() -> URL {
        return imageUrls[currentImageIndex]
    }
}

