import UIKit

extension UIViewController {
    func hideNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func showNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

class ViewController: UIViewController {
    
    let greetings = ["Привет", "Hello", "Bonjour", "Hola", "Ciao"]
    let imageUrls = [
        URL(string: "https://images2.alphacoders.com/576/576627.jpg")!,
        URL(string: "https://wallpaperaccess.com/full/7316.jpg")!,
        URL(string: "https://images.hdqwalls.com/wallpapers/dota-2-templar-assassin-cosmetic-set-4k-mg.jpg")!
    ]
    
    var currentIndex = 0
    var currentImageIndex = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.self.hideNavigationBar()
    }
    
    let greeting: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let spinner: UIActivityIndicatorView = {
        let imageDownloading = UIActivityIndicatorView(style: .large)
        imageDownloading.translatesAutoresizingMaskIntoConstraints = false
        return imageDownloading
    }()
    
    let imageContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let changeImage: UIButton = {
        let changeImage = UIButton()
        changeImage.setTitle("Нажми меня", for: .normal)
        changeImage.setTitleColor(.white, for: .normal)
        changeImage.backgroundColor = .gray
        changeImage.translatesAutoresizingMaskIntoConstraints = false
        return changeImage
    }()
    
    let notFoundLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Not Found"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        
        view.addSubview(greeting)
        view.addSubview(imageContainerView)
        view.addSubview(changeImage)
        imageContainerView.addSubview(imageView)
        imageContainerView.addSubview(notFoundLabel)
        imageContainerView.addSubview(spinner)
        
        let safeGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            greeting.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: 10),
            greeting.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 10),
            greeting.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor, constant: -10),
            
            imageContainerView.topAnchor.constraint(equalTo: greeting.bottomAnchor, constant: 10),
            imageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageContainerView.bottomAnchor.constraint(equalTo: changeImage.topAnchor, constant: -10),
            
            imageView.topAnchor.constraint(equalTo: imageContainerView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: imageContainerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: imageContainerView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: imageContainerView.bottomAnchor),
            
            changeImage.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 10),
            changeImage.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor, constant: -10),
            changeImage.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor, constant: -10),
            changeImage.heightAnchor.constraint(equalToConstant: 40),
            
            // Ограничения для индикатора внутри внешнего контейнера
            spinner.centerXAnchor.constraint(equalTo: imageContainerView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: imageContainerView.centerYAnchor),
            
            notFoundLabel.centerXAnchor.constraint(equalTo: imageContainerView.centerXAnchor),
            notFoundLabel.centerYAnchor.constraint(equalTo: imageContainerView.centerYAnchor),
        ])
        
        changeImage.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        imageContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openImage)))
        
        updateUI()
    }
    
    @objc func buttonTapped() {
        currentIndex = (currentIndex + 1) % greetings.count
        currentImageIndex = (currentImageIndex + 1) % imageUrls.count
        updateUI()
    }
    
    @objc func openImage() {
        let imageViewController = ImageViewController()
        // Устанавливаем URL изображения для ImageViewController
        imageViewController.imageUrl = imageUrls[self.currentImageIndex]
        navigationController?.pushViewController(imageViewController, animated: true)
    }
    
    private func downloadImage() {
        let imageUrl = imageUrls[self.currentImageIndex]
        spinner.startAnimating()
        notFoundLabel.isHidden = true
        
        URLSession.shared.dataTask(with: URLRequest(url: imageUrl, timeoutInterval: 10.0)) { [weak self] data, _, _ in
            guard let this = self else { return }
            guard imageUrl == this.imageUrls[this.currentImageIndex] else { return }
            DispatchQueue.main.async {
                this.spinner.stopAnimating()
                if let data, let image = UIImage(data: data) {
                    this.imageView.image = image
                } else {
                    this.notFoundLabel.isHidden = false
                }
            }
        }.resume()
    }
    
    func updateUI() {
        greeting.text = greetings[currentIndex]
        imageView.image = nil  // Очищаем изображение при смене контента
        // Загружаем новое изображение
        downloadImage()
    }
}
