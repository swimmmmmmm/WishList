import CoreData
import Foundation

class CoreDataManager {
    static var shared: CoreDataManager = CoreDataManager()

    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Product")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()


    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    var productEntity: NSEntityDescription? {
        return  NSEntityDescription.entity(forEntityName: "ProductEntity", in: context)
    }

    func saveToContext() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }

    func insertProduct(_ product: RemoteProduct) {
        if let entity = productEntity {
            let managedObject = NSManagedObject(entity: entity, insertInto: context)
            managedObject.setValue(product.id, forKey: "id")
            managedObject.setValue(product.title, forKey: "title")
            managedObject.setValue(product.description, forKey: "descriptionProduct")
            managedObject.setValue(product.price, forKey: "price")
            managedObject.setValue(product.discountPercentage, forKey: "discountPercentage")
            managedObject.setValue(product.rating, forKey: "rating")
            managedObject.setValue(product.stock, forKey: "stock")
            managedObject.setValue(product.brand, forKey: "brand")
            managedObject.setValue(product.category, forKey: "category")
            managedObject.setValue(product.thumbnail, forKey: "thumbnail")
            managedObject.setValue(product.images, forKey: "images")
            saveToContext()
        }
    }

    func fetchProducts() -> [ProductEntity] {
        do {
            let request = ProductEntity.fetchRequest()
            let results = try context.fetch(request)

            return results
        } catch {
            print(error.localizedDescription)
        }
        return []
    }

    func getProducts() -> [RemoteProduct] {
        var products: [RemoteProduct] = []
        let fetchResults = fetchProducts()
        for result in fetchResults {
            let product = RemoteProduct(id: Int(result.id),
                                        title: result.title!,
                                        description: result.descriptionProduct!,
                                        price: Int(result.price),
                                        discountPercentage: result.discountPercentage,
                                        rating: result.rating,
                                        stock: Int(result.stock),
                                        brand: result.brand!,
                                        category: result.category!,
                                        thumbnail: result.thumbnail!,
                                        images: result.images)
            products.append(product)
        }
        return products
    }

    func removeAll() {
        let fetchResults = fetchProducts()
        for result in fetchResults {
            context.delete(result)
        }
        saveToContext()
    }
}
