import UIKit

class ZoomedImageController: UIViewController {
    private let zoomedImageView: ZoomedImageInteractive
    private let imageModel: ImageModelabel

    init(zoomedImageView: ZoomedImageInteractive, imageModel: ImageModelabel) {
        self.zoomedImageView = zoomedImageView
        self.imageModel = imageModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = zoomedImageView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.zoomedImageView.setSpinnerAnimating(true)
        self.imageModel.getImage { [weak self] image in
            self?.zoomedImageView.setSpinnerAnimating(false)
            self?.zoomedImageView.setImage(image)
        }
    }
}
