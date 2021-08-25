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
    lazy var elements = makeElements()
    
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
    
    func makeElements() -> Driver<[MeditationDashboardCollectionElement]> {
        dashboard
            .map { dashboard -> [MeditationDashboardCollectionElement] in
                var result = [MeditationDashboardCollectionElement]()
                
                result.append(.offset(24.scale))
                
                if let daily = dashboard.daily {
                    result.append(.daily(daily))
                    result.append(.offset(24.scale))
                }
                
                if !dashboard.courses.isEmpty {
                    result.append(.title("MeditationsDashboard.Courses.Title".localized))
                    result.append(.offset(8.scale))
                    result.append(.subTitle("MeditationsDashboard.Courses.SubTitle".localized))
                    result.append(.offset(16.scale))
                    
                    dashboard.courses.enumerated().forEach { index, course in
                        result.append(.course(course))
                        
                        if index != (dashboard.courses.count - 1) {
                            result.append(.offset(12.scale))
                        }
                    }
                    
                    result.append(.offset(24.scale))
                }
                
                if !dashboard.groupes.isEmpty {
                    dashboard.groupes.enumerated().forEach { groupIndex, group in
                        result.append(.title(group.title))
                        result.append(.offset(16.scale))
                        
                        group.audios.enumerated().forEach { audioIndex, audio in
                            result.append(.audio(audio))
                            
                            if (audioIndex % 2 == 0) && audioIndex != (group.audios.count - 1) {
                                result.append(.offset(12.scale))
                            }
                        }
                        
                        if groupIndex != (dashboard.groupes.count - 1) {
                            result.append(.offset(24.scale))
                        }
                    }
                }
                
                return result
            }
    }
}
