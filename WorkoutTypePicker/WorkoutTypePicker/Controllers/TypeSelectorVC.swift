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
        self.tableView.insertRows(at: [IndexPath.init(row: typeService.workoutTypes.count - 1, section: 0)], with: .automatic)
        
        
        
    }
    
    
    
    
    
    // MARK: TableView dataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredTypes.count
        }
        
        return typeService.workoutTypes.count
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var workout = typeService.workoutTypes[indexPath.row]
        
        if isFiltering {
            workout = filteredTypes[indexPath.row]
            
            
        } else {
            workout = typeService.workoutTypes[indexPath.row]
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
    
    
    // MARK: Navigation
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showDetail" {
//            if let indexPath = tableView.indexPathForSelectedRow {
//                let workout: WorkoutType
//
//
//                if isFiltering {
//                    workout = filteredWorkouts[indexPath.row]
//                } else {
//                    workout = typeService.workoutTypes[indexPath.row]
//                }
//
//                let detailVC = segue.destination as! DetailViewController
//                detailVC.workoutType = workout
//            }
//        }
//    }
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
