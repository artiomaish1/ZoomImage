import UIKit

class GreetingsURLController: UIViewController {
    var model: GreetingModel!
    var viewElements: GreetingsURLView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewElements = GreetingsURLView()
        viewElements.setupConstraints(in: view)
        viewElements.changeImage.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        viewElements.imageContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openImage)))
        
        model = GreetingModel()
        updateUI()
    }
    
    func updateUI() {
        let greetingText = model.currentGreeting()
        viewElements.updateGreetingLabel(withText: greetingText)
        
        let imageUrl = model.currentImageUrl()
        viewElements.updateImageView(withImage: nil)
        viewElements.showSpinner()
        viewElements.showNotFoundLabel(false)
        
        downloadImage(from: imageUrl)
    }
    
    private func downloadImage(from url: URL) {
        URLSession.shared.dataTask(with: URLRequest(url: url, timeoutInterval: 10.0)) { [weak self] data, _, _ in
            guard let this = self else { return }
            DispatchQueue.main.async {
                this.viewElements.hideSpinner()
                if let data, let image = UIImage(data: data) {
                    this.viewElements.updateImageView(withImage: image)
                } else {
                    this.viewElements.showNotFoundLabel(true)
                }
            }
        }.resume()
    }
    
    @objc func buttonTapped() {
        model.nextGreeting()
        updateUI()
    }
    
    @objc func openImage() {
        let imageModel = model.imageModel
        let imageViewController = ZoomedImageController(zoomedImageView: ZoomedImageView(), imageModel: imageModel)
        navigationController?.pushViewController(imageViewController, animated: true)
    }
}



