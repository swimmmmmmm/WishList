import UIKit

class ViewController: UIViewController {

    let networkManager = NetworkManager.shared

    let coredataManager = CoreDataManager.shared

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    let productView = ProductView()

    var product: RemoteProduct?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setUp()
        setUpLayout()

        Task {
            await self.product = self.getProduct()
            await self.setUIData(with: self.product!)
//            readCoreData()
         }
        
        coredataManager.removeAll()
    }

    private func setUp() {
        productView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(imageView)
        view.addSubview(productView)
    }

    func setUpLayout() {
        NSLayoutConstraint.activate([

            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:
            0),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            constant: 0),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 0),
            imageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),


            productView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0),
            productView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            productView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            productView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
        ])
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

    func insertCoreData(product: RemoteProduct) {
        coredataManager.insertProduct(product)
    }

    func readCoreData() {
        dump(coredataManager.getProducts())
    }
}

