import UIKit

protocol GreetingView: AnyObject {
    func updateUI(with model: GreetingModel)
}

class ViewController: UIViewController, GreetingView {
    var viewElements = GreetingViewElements()
    var model = GreetingModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        viewElements.setupConstraints(in: view)
        
        viewElements.changeImage.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        viewElements.imageContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openImage)))
        
        updateUI(with: model)
    }
    
    func updateUI(with model: GreetingModel) {
        viewElements.greetingLabel.text = model.greetings[model.currentIndex]
        viewElements.imageView.image = nil
        downloadImage(from: model.imageUrls[model.currentImageIndex])
    }
    
    private func downloadImage(from url: URL) {
        
        let imageUrl = model.imageUrls[model.self.currentImageIndex]
        viewElements.spinner.startAnimating()
        viewElements.notFoundLabel.isHidden = true
        
        URLSession.shared.dataTask(with: URLRequest(url: url, timeoutInterval: 10.0)) { [weak self] data, _, _ in
            guard let this = self else { return }
            guard imageUrl == this.model.imageUrls[this.model.currentImageIndex] else { return }
            DispatchQueue.main.async {
                this.viewElements.spinner.stopAnimating()
                if let data, let image = UIImage(data: data) {
                    this.viewElements.imageView.image = image
                } else {
                    this.viewElements.notFoundLabel.isHidden = false
                }
            }
        }.resume()
    }
    
    @objc func buttonTapped() {
        model.currentIndex = (model.currentIndex + 1) % model.greetings.count
        model.currentImageIndex = (model.currentImageIndex + 1) % model.imageUrls.count
        updateUI(with: model)
    }
    
    @objc func openImage() {
        let imageViewController = ImageViewController()
        imageViewController.imageModel.imageUrl = model.imageUrls[model.currentImageIndex]
        navigationController?.pushViewController(imageViewController, animated: true)
    }
}
