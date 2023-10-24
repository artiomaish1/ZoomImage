import UIKit
import Foundation

class GreetingsURLController: UIViewController {
    private var model: GreetingsModelable
    private let greetingsUrlView: GreetingsURLInterective

    init(model: GreetingsModelable, greetingsUrlView: GreetingsURLInterective) {
        self.model = model
        self.greetingsUrlView = greetingsUrlView
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = greetingsUrlView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        greetingsUrlView.configureChangeImageTarget(target: self, action: #selector(buttonTapped))
        greetingsUrlView.configureImageContainerGestureRecognizer(target: self, action: #selector(openImage))

        updateUI()
    }

    private func updateUI() {
        greetingsUrlView.setSpinnerAnimating(true)
        greetingsUrlView.showNotFoundLabel(false)

        model.downloadImage { [weak self] image in
            guard let this = self else { return }

            if let image = image {
                this.greetingsUrlView.updateImageView(withImage: image)
            } else {
                this.greetingsUrlView.showNotFoundLabel(true)
            }

            let greetingText = this.model.currentGreeting
            this.greetingsUrlView.updateGreetingLabel(withText: greetingText)
            this.greetingsUrlView.updateImageView(withImage: image)
            this.greetingsUrlView.setSpinnerAnimating(false)

        }
    }

    @objc func buttonTapped() {
        model.nextGreetingURL()
        updateUI()
    }

    @objc func openImage() {
        let imageModel = ImageModel(imageUrl: model.currentImageUrl)
        let imageViewController = ZoomedImageController(zoomedImageView: ZoomedImageView(), imageModel: imageModel)
        navigationController?.pushViewController(imageViewController, animated: true)
    }
}
