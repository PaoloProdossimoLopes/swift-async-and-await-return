//
//  ViewController.swift
//  asyncAndAwait
//
//  Created by Paolo Prodossimo Lopes on 27/03/22.
//

import UIKit

class ViewController: UITableViewController {
    
    private var listOfItens: [Post] = []
    private let service = PostsService()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPosts()
    }
    
    private func fetchPosts() {
        Task(priority: .background) { [weak self] in
            guard let self = self else { return }
            let result = await service.fetchPosts()
            
            switch result {
            case .success(let responseModel):
                self.listOfItens = responseModel
            case .failure(let error):
                print("DEBUG: \(error.customMessage)")
            }
            
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfItens.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = listOfItens[indexPath.row].title
        cell.detailTextLabel?.text = listOfItens[indexPath.row].body
        return cell
    }
}

