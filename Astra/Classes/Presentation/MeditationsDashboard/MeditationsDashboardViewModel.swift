//
//  MeditationsDashboardViewModel.swift
//  Astra
//
//  Created by Andrey Chernyshev on 24.08.2021.
//

import RxSwift
import RxCocoa

final class MeditationsDashboardViewModel {
    lazy var filters = makeFilters()
    
    private lazy var dashboard = makeDashboard()
    
    private lazy var meditationManager = MeditationManagerCore()
}

// MARK: Private
private extension MeditationsDashboardViewModel {
    func makeDashboard() -> Driver<MeditationDashboard> {
        meditationManager
            .obtainDashboard()
            .compactMap { $0 }
            .asDriver(onErrorDriveWith: .empty())
    }
    
    func makeFilters() -> Driver<[MeditationsFilterCollectionElement]> {
        dashboard
            .map { dashboard -> [MeditationsFilterCollectionElement] in
                var result = [MeditationsFilterCollectionElement]()
                
                let all = MeditationsFilterCollectionElement(code: .all,
                                                             isSelected: true)
                result.append(all)
                
                if !dashboard.courses.isEmpty {
                    let courses = MeditationsFilterCollectionElement(code: .courses,
                                                                     isSelected: false)
                    result.append(courses)
                }
                
                dashboard.groupes.forEach { group in
                    let another = MeditationsFilterCollectionElement(code: .another(group.title),
                                                                     isSelected: false)
                    result.append(another)
                }
                
                return result
            }
    }
}
