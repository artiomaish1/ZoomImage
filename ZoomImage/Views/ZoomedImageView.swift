import UIKit

protocol ZoomedImageInteractive: UIView {
    func setSpinnerAnimating(_ animating: Bool)
    func setImage(_ image: UIImage?)
    func showNotFoundZoomdeImage(_ show: Bool)
}

class ZoomedImageView: UIView, UIScrollViewDelegate, ZoomedImageInteractive {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.clipsToBounds = false
        return scrollView
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let notFoundZoomdedImage: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
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
        backgroundColor = .black

        scrollView.delegate = self
        scrollView.maximumZoomScale = 5.0

        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(doubleTap))
        doubleTapGesture.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTapGesture)

        self.addSubview(scrollView)
        scrollView.addSubview(imageView)
        self.addSubview(activityIndicator)
        self.addSubview(notFoundZoomdedImage)

        let safeGuide = self.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor, constant: 0),

            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1),
            imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1),

            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            notFoundZoomdedImage.centerXAnchor.constraint(equalTo: safeGuide.centerXAnchor),
            notFoundZoomdedImage.centerYAnchor.constraint(equalTo: safeGuide.centerYAnchor)
        ])
    }

    @objc private func doubleTap(sender: UITapGestureRecognizer) {
        if scrollView.zoomScale == 1 {
            let zoomRect = zoomRectForScale(scale: scrollView.maximumZoomScale,
                                            center: sender.location(in: sender.view))
            scrollView.zoom(to: zoomRect, animated: true)
        } else {
            scrollView.setZoomScale(1, animated: true)
        }
    }

    func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = imageView.frame.size.height / scale
        zoomRect.size.width = imageView.frame.size.width / scale
        let newCenter = imageView.convert(center, from: scrollView)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    func setSpinnerAnimating(_ animating: Bool) {
        if animating {
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
        }
    }
    func setImage(_ image: UIImage?) {
        self.imageView.image = image
    }

    func showNotFoundZoomdeImage(_ show: Bool) {
        notFoundZoomdedImage.isHidden = !show
    }
}
