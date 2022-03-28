//
//  DetailViewController.swift
//  WorkoutTypePicker
//
//  Created by Андрей  on 24.03.2022.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    var workoutType: WorkoutType!
    
    
    @IBOutlet weak var workoutImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = workoutType.name
        workoutImage.image = UIImage(named: workoutType.type.rawValue)
        
    }
    
    
    
}
