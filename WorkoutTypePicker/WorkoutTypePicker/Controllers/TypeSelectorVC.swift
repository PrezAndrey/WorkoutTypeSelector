//
//  ViewController.swift
//  WorkoutTypePicker
//
//  Created by Андрей  on 24.03.2022.
//

import UIKit

class TypeSelectorVC: UITableViewController {
    
    private var typeService = TypeService()
    
    private var mainScreenVC = MainScreenVC()
    
    weak var delegate: TypeSelectorDelegate?
    
    var service: TypeSelectorService?
    
    
    
    
//    private var filteredWorkouts = [WorkoutType]()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var searchIsBarEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        
        return searchController.isActive && !searchIsBarEmpty
    }
    
    private var filteredTypes = [WorkoutType]()

    
    
    @IBOutlet weak var addCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Название или тип тренировки"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        delegate = mainScreenVC
        service = typeService
        
        
        
        
    }
    
    
    
    
    
    // MARK: TableView dataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            if noCouples(searchController.searchBar.text!) {
                return filteredTypes.count + 1
            }
            return filteredTypes.count
        }
        
        return typeService.workoutTypes.count
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var workout = typeService.workoutTypes[indexPath.row]
        
        if isFiltering {
            if indexPath.row == filteredTypes.count {
                if let cell = Bundle.main.loadNibNamed("ButtonView", owner: self, options: nil)?.first as? ButtonView {
                    cell.didAddButton.setTitle("Добавить новый тип: \(searchController.searchBar.text!)", for: .normal)
                    cell.didAddButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
                    
                    return cell
                }
                
                return UITableViewCell()
            }
            workout = filteredTypes[indexPath.row]
            
            
        }
        
        
        
        cell.textLabel?.text = workout.name
        cell.detailTextLabel?.text = workout.type.rawValue
        
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.typeSelector(self, didSelectType: typeService.workoutTypes[indexPath.row])
        //print(typeService.workoutTypes[indexPath.row].name)
        
        navigationController?.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    @objc func buttonPressed(sender: UIButton) {
        print("Cell button is working!")
        service?.createType(with: searchController.searchBar.text!, completion: { result in
            switch result {
            case .success(let newType):
                self.filteredTypes.append(newType)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure:
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            
            }
        })
    }
    
    private func noCouples(_ searchResult: String) -> Bool {
        var flag = true
        for i in typeService.workoutTypes {
            if i.name == searchResult {
                flag = false
            }
        }
        return flag
    }
}

extension TypeSelectorVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    service?.fetchTypes(for: searchController.searchBar.text!, completion: { result in
        switch result {
        case .success(let filteredArray):
            self.filteredTypes = filteredArray
            //self.types = filteredArray
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        case .failure:
            self.filteredTypes = [WorkoutType]()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    })
    }
}
