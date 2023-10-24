import UIKit
import Foundation

protocol LabelsURLInterective: UIView {
    func setSpinnerAnimating(_ animating: Bool)
    func updateImageView(withImage image: UIImage?)
    func configureChangeImageTarget(target: Any, action: Selector)
    func configureImageContainerGestureRecognizer(target: Any, action: Selector)
    func showNotFoundLabel(_ show: Bool)
    func updateLabelText(withText text: String)
}

class GreetingsURLView: UIView, LabelsURLInterective {
    private let greetingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let spinner: UIActivityIndicatorView = {
        let imageDownloading = UIActivityIndicatorView(style: .large)
        imageDownloading.translatesAutoresizingMaskIntoConstraints = false
        return imageDownloading
    }()

    private let imageContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let changeImage: UIButton = {
        let changeImage = UIButton()
        changeImage.setTitle("Нажми меня", for: .normal)
        changeImage.setTitleColor(.white, for: .normal)
        changeImage.backgroundColor = .gray
        changeImage.translatesAutoresizingMaskIntoConstraints = false
        return changeImage
    }()

    private let notFoundLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Not Found"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraints() {
        self.backgroundColor = .white

        self.addSubview(greetingLabel)
        self.addSubview(imageContainerView)
        self.addSubview(changeImage)
        imageContainerView.addSubview(imageView)
        imageContainerView.addSubview(notFoundLabel)
        imageContainerView.addSubview(spinner)

        let safeGuide = self.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            greetingLabel.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: 10),
            greetingLabel.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 10),
            greetingLabel.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor, constant: -10),

            imageContainerView.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 10),
            imageContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageContainerView.bottomAnchor.constraint(equalTo: changeImage.topAnchor, constant: -10),

            imageView.topAnchor.constraint(equalTo: imageContainerView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: imageContainerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: imageContainerView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: imageContainerView.bottomAnchor),

            changeImage.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 10),
            changeImage.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor, constant: -10),
            changeImage.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor, constant: -10),
            changeImage.heightAnchor.constraint(equalToConstant: 40),

            spinner.centerXAnchor.constraint(equalTo: imageContainerView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: imageContainerView.centerYAnchor),

            notFoundLabel.centerXAnchor.constraint(equalTo: imageContainerView.centerXAnchor),
            notFoundLabel.centerYAnchor.constraint(equalTo: imageContainerView.centerYAnchor)
        ])
    }

    func configureChangeImageTarget(target: Any, action: Selector) {
        changeImage.addTarget(target, action: action, for: .touchUpInside)
    }

    func configureImageContainerGestureRecognizer(target: Any, action: Selector) {
        imageContainerView.addGestureRecognizer(UITapGestureRecognizer(target: target, action: action))
    }

    func updateLabelText(withText text: String) {
        greetingLabel.text = text
    }

    func updateImageView(withImage image: UIImage?) {
        imageView.image = image
    }

    func setSpinnerAnimating(_ animating: Bool) {
        if animating {
            self.spinner.startAnimating()
        } else {
            self.spinner.stopAnimating()
        }
    }

    func showNotFoundLabel(_ show: Bool) {
        notFoundLabel.isHidden = !show
    }
}
