import UIKit

class ViewController: UIViewController {

    let greetings = ["Привет", "Hello", "Bonjour", "Hola", "Ciao"]
    let images = [UIImage(named: "firstPhoto"), UIImage(named: "secondPhoto"), UIImage(named: "thirdPhoto")]

    var currentIndex = 0

    let greeting: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let changeImage: UIButton = {
        let changeImage = UIButton()
        changeImage.setTitle("Нажми меня", for: .normal)
        changeImage.setTitleColor(.white, for: .normal)
        changeImage.backgroundColor = .blue
        changeImage.translatesAutoresizingMaskIntoConstraints = false
        return changeImage
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white

        view.addSubview(greeting)
        view.addSubview(imageView)
        view.addSubview(changeImage)

        let safeGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            greeting.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: 10),
            greeting.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 10),
            greeting.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor, constant: -10),

            imageView.topAnchor.constraint(equalTo: greeting.bottomAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: changeImage.topAnchor, constant: -10),

            changeImage.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 10),
            changeImage.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor, constant: -10),
            changeImage.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor, constant: -10),
            changeImage.heightAnchor.constraint(equalToConstant: 40)
        ])

        changeImage.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        updateUI()
    }

    @objc func buttonTapped() {
        currentIndex = (currentIndex + 1) % greetings.count
        updateUI()
        
        if currentIndex == 0 {
            let imageViewController = ImageViewController()
            imageViewController.image = images[2]
            navigationController?.pushViewController(imageViewController, animated: true)
        }
    }

    func updateUI() {
        greeting.text = greetings[currentIndex]
        imageView.image = images[currentIndex % images.count]
    }
}


