import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    func fetchRemoteProduct(id: Int) async -> RemoteProduct? {
        let request = URLRequest(url: URL(string: "https://dummyjson.com/products/\(id)")!)

        do {
            //디코딩까지 묶어서 작업한 뒤 리턴
            let (data, _) = try await URLSession.shared.data(for: request)
            let product = try JSONDecoder().decode(RemoteProduct.self, from: data)
            return product
        }
        catch {
            debugPrint("Error loading : \(String(describing: error))")
            return nil
        }
    }

}
