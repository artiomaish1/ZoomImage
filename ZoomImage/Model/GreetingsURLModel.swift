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
}

