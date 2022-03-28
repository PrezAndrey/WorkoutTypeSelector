//
//  TypeService.swift
//  WorkoutTypePicker
//
//  Created by Андрей  on 25.03.2022.
//

import Foundation



protocol TypeSelectorService {
    
    func fetchTypes(for query: String, completion: @escaping (Result<[WorkoutType], Error>) -> Void )
    
    func createType(with name: String, completion: @escaping (Result<String, Error>) -> Void )
}

class TypeService {
    
    var filteredWorkouts = [WorkoutType]()
    
    let workoutTypes = [
        WorkoutType(name: "Йога", type: .mixed),
        WorkoutType(name: "Пилатес", type: .aerobic),
        WorkoutType(name: "Танцевальные групповые тренировки", type: .aerobic),
        WorkoutType(name: "Танцевальная аэробика", type: .aerobic),
        WorkoutType(name: "Кардиотренировки", type: .aerobic),
        WorkoutType(name: "Сайкл", type: .aerobic),
        WorkoutType(name: "Силовые тренировки", type: .anaerobic),
        WorkoutType(name: "Кроссфит", type: .aerobic)
    ]
    
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredWorkouts = workoutTypes.filter({ (workoutT: WorkoutType) -> Bool in
            return workoutT.name.lowercased().contains(searchText.lowercased()) || workoutT.type.rawValue.lowercased().contains(searchText.lowercased())
        })
    }
    
    
}

extension TypeService: TypeSelectorService {
    func fetchTypes(for query: String, completion: @escaping (Result<[WorkoutType], Error>) -> Void) {
        filterContentForSearchText(query)
        completion(.success(filteredWorkouts))
        
    }

    func createType(with name: String, completion: @escaping (Result<String, Error>) -> Void) {
        
    }
    
    
}


