//
//  ProductEntity+CoreDataProperties.swift
//  WishList
//
//  Created by 서수영 on 4/11/24.
//
//

import Foundation
import CoreData

extension ProductEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductEntity> {
        return NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
    }

    @NSManaged public var brand: String?
    @NSManaged public var category: String?
    @NSManaged public var descriptionProduct: String?
    @NSManaged public var discountPercentage: Double
    @NSManaged public var id: Int16
    @NSManaged public var images: [String]
    @NSManaged public var price: Int16
    @NSManaged public var rating: Double
    @NSManaged public var stock: Int16
    @NSManaged public var thumbnail: String?
    @NSManaged public var title: String?

}

extension ProductEntity : Identifiable {

}
