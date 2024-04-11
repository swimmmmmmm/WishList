import UIKit

class ViewController: UIViewController {

    let networkManager = NetworkManager.shared

    let coredataManager = CoreDataManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue

        Task {
            await self.getProduct()
            readCoreData()
         }

        
//        coredataManager.removeAll()
    }

    func getProduct() async {
        let product = await networkManager.fetchRemoteProduct(id: (1...100).randomElement()!)
        dump(product!)
        insertCoreData(product: product!)
    }

    func insertCoreData(product: RemoteProduct) {
        coredataManager.insertProduct(product)
    }

    func readCoreData() {
        dump(coredataManager.getProducts())
    }
}

