import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    var elements = ImageViewElements()
    var imageModel = ImageModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        elements.setupConstraints(in: view)
        
        if let imageUrl = imageModel.imageUrl {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageUrl), let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self.elements.activityIndicator.stopAnimating()
                        self.elements.imageView.image = image
                    }
                }
            }
        }
        
        elements.scrollView.delegate = self
        elements.scrollView.maximumZoomScale = 5.0
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(doubleTap))
        doubleTapGesture.numberOfTapsRequired = 2
        elements.scrollView.addGestureRecognizer(doubleTapGesture)
    }
    
    @objc func doubleTap(sender: UITapGestureRecognizer) {
        if elements.scrollView.zoomScale == 1 {
            let zoomRect = zoomRectForScale(scale: elements.scrollView.maximumZoomScale, center: sender.location(in: sender.view))
            elements.scrollView.zoom(to: zoomRect, animated: true)
        } else {
            elements.scrollView.setZoomScale(1, animated: true)
        }
    }
    
    func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = elements.imageView.frame.size.height / scale
        zoomRect.size.width = elements.imageView.frame.size.width / scale
        let newCenter = elements.imageView.convert(center, from: elements.scrollView)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return elements.imageView
    }
}
