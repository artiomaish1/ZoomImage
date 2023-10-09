import UIKit

class ImageViewElements {
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.clipsToBounds = false
        return scrollView
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func setupConstraints(in view: UIView) {
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        view.addSubview(activityIndicator)
        
        let safeGuide = view.safeAreaLayoutGuide
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
            
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
