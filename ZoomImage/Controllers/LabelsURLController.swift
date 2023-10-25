import UIKit
import Foundation

class LabelsURLController: UIViewController {
    private var model: LabelsURLsDownloadable
    private let labelsUrlView: LabelsURLInterective

    init(model: LabelsURLsDownloadable, greetingsUrlView: LabelsURLInterective) {
        self.model = model
        self.labelsUrlView = greetingsUrlView
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = labelsUrlView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        labelsUrlView.configureChangeImageTarget(target: self, action: #selector(buttonTapped))
        labelsUrlView.configureImageContainerGestureRecognizer(target: self, action: #selector(openImage))

        updateUI()
    }

    private func updateUI() {
        labelsUrlView.setSpinnerAnimating(true)
        labelsUrlView.showNotFoundLabel(false)

        model.downloadImage { [weak self] image in
            guard let this = self else { return }

            if let image = image {
                this.labelsUrlView.updateImageView(withImage: image)
            } else {
                this.labelsUrlView.showNotFoundLabel(true)
            }

            let labelText = this.model.currentLabel
            this.labelsUrlView.updateLabelText(withText: labelText)
            this.labelsUrlView.updateImageView(withImage: image)
            this.labelsUrlView.setSpinnerAnimating(false)

        }
    }

    @objc func buttonTapped() {
        model.nextLabelURL()
        updateUI()
    }

    @objc func openImage() {
        let imageModel = ImageModel(imageUrl: model.currentImageUrl)
        let imageViewController = ZoomedImageController(zoomedImageView: ZoomedImageView(), imageModel: imageModel)
        navigationController?.pushViewController(imageViewController, animated: true)
    }
}
