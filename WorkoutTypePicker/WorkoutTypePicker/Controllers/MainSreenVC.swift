//
//  MainSreenVC.swift
//  WorkoutTypePicker
//
//  Created by Андрей  on 25.03.2022.
//

import Foundation
import UIKit

protocol TypeSelectorDelegate: class {
    
    func typeSelector(_ typeSelector: TypeSelectorVC, didSelectType: WorkoutType)
}

class MainScreenVC: UIViewController {
    
    var detailVC = DetailViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
    }
    
   
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showDetail" {
//
//
//                let detailVC = segue.destination as! DetailViewController
////                detailVC.workoutType = workout
//                print("done")
//            }
//        }
    
    
    
}

extension MainScreenVC: TypeSelectorDelegate {
    func typeSelector(_ typeSelector: TypeSelectorVC, didSelectType: WorkoutType) {
        print("From MainScrenVC, send: \(didSelectType)")
        detailVC.workoutType = didSelectType
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "detailScreen")
        self.present(vc, animated: true, completion: nil)
        
        
        
    
        
        
    }
}
