import UIKit
import Foundation

class GreetingsURLView: UIView {
    let greetingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
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
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Not Found"
        return label
    }()

//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.setupConstraints()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    func setupConstraints(in view: UIView) {
        view.backgroundColor = .white

        view.addSubview(greetingLabel)
        view.addSubview(imageContainerView)
        view.addSubview(changeImage)
        imageContainerView.addSubview(imageView)
        imageContainerView.addSubview(notFoundLabel)
        imageContainerView.addSubview(spinner)

        let safeGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            greetingLabel.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: 10),
            greetingLabel.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 10),
            greetingLabel.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor, constant: -10),

            imageContainerView.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 10),
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

    func updateGreetingLabel(withText text: String) {
        greetingLabel.text = text
    }

    func updateImageView(withImage image: UIImage?) {
        imageView.image = image
    }

    func showSpinner() {
        spinner.startAnimating()
    }

    func hideSpinner() {
        spinner.stopAnimating()
    }

    func showNotFoundLabel(_ show: Bool) {
        notFoundLabel.isHidden = !show
    }
}
