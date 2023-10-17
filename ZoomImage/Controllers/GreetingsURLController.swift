import UIKit
import Foundation

class GreetingsURLController: UIViewController {
    private var model: GreetingsModelable
    private let greetingsUrlView: GreetingsURLView

    init(model: GreetingModel, greetingsUrlView: GreetingsURLView) {
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

        greetingsUrlView.setupConstraints(in: view)
        greetingsUrlView.configureChangeImageTarget(target: self, action: #selector(buttonTapped))
        greetingsUrlView.configureImageContainerGestureRecognizer(target: self, action: #selector(openImage))

        updateUI()
    }

    private func updateUI() {
        greetingsUrlView.showSpinner()
        greetingsUrlView.showNotFoundLabel(false)

        model.updateUI { [weak self] in
            guard let this = self else { return }
            let greetingText = this.model.currentGreeting
            this.greetingsUrlView.updateGreetingLabel(withText: greetingText)
            this.greetingsUrlView.hideSpinner()
        }
    }

    @objc func buttonTapped() {
        model.nextGreeting()
        updateUI()
    }

    @objc func openImage() {
        let imageModel = (model as GreetingsModelable).createImageModel()
        let imageViewController = ZoomedImageController(zoomedImageView: ZoomedImageView(), imageModel: imageModel)
        navigationController?.pushViewController(imageViewController, animated: true)
    }
}
