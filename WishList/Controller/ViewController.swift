import UIKit

class ViewController: UIViewController {

    let networkManager = NetworkManager.shared
    let coredataManager = CoreDataManager.shared

    var product: RemoteProduct?

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    let productView = ProductView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setUpUI()
        setUpLayout()
        loadData()
    }

    private func setUpUI() {
        productView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(imageView)
        view.addSubview(productView)

        productView.showNextButton.addTarget(self, action: #selector(loadData), for: .touchUpInside)
        productView.addListButton.addTarget(self, action: #selector(insertCoreData), for: .touchUpInside)
        productView.showListButton.addTarget(self, action: #selector(moveToList), for: .touchUpInside)
    }

    func setUpLayout() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),

            productView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0),
            productView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            productView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            productView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
        ])
    }

    @objc
    func moveToList() {
        let wishListTableVC = WishListTableViewController()

        self.present(wishListTableVC, animated: true)
    }
}

// MARK: - 네트워킹
extension ViewController {

    @objc
    func loadData() {
        Task {
            await self.product = self.getProduct()
            await self.setUIData(with: self.product!)
        }
    }

    func setUIData(with product: RemoteProduct) async {
        productView.titleLabel.text = product.title
        productView.descriptionTextView.text = product.description

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal

        productView.priceLabel.text = formatter.string(from: NSNumber(integerLiteral: product.price))! + "$"

        if let (data, _) = try? await URLSession.shared.data(from: URL(string: product.thumbnail)!),
           let image = UIImage(data: data) {
            imageView.image = image
        }
    }

    func getProduct() async -> RemoteProduct? {
        let product = await networkManager.fetchRemoteProduct(id: (1...100).randomElement()!)
        dump(product!)
        return product
    }
}

// MARK: - 코어데이터
extension ViewController {

    @objc
    func insertCoreData() {
        coredataManager.insertProduct(self.product!)
    }

    func readCoreData() {
        dump(coredataManager.getProducts())
    }
}
