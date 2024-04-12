//
//  WishListViewControllerTableViewController.swift
//  WishList
//
//  Created by 서수영 on 4/12/24.
//

import UIKit

class WishListTableViewController: UITableViewController {
    
    let coredataManager = CoreDataManager.shared

    var wishList: [RemoteProduct]?


    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        readCoreData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return wishList?.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        let wishProduct = wishList![indexPath.row]

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal

        cell.textLabel!.text = "[\(wishProduct.id)] \(wishProduct.title) - \(formatter.string(from: NSNumber(integerLiteral: wishProduct.price))! + "$")"
        return cell
    }

//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }    
//    }
}

extension WishListTableViewController {

    func readCoreData() {
//        dump(coredataManager.getProducts())
        self.wishList = coredataManager.getProducts()
    }
}
