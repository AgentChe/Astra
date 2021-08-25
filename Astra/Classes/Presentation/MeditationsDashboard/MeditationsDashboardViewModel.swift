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
    
    func makeElements() -> Driver<[MeditationDashboardCollectionSection]> {
        dashboard
            .map { dashboard -> [MeditationDashboardCollectionSection] in
                var result = [MeditationDashboardCollectionSection]()
                
                var elementsSection1 = [MeditationDashboardCollectionElement]()
                var elementsSection2 = [MeditationDashboardCollectionElement]()
                
                elementsSection1.append(.offset(24.scale))
                
                if let daily = dashboard.daily {
                    elementsSection1.append(.daily(daily))
                    elementsSection1.append(.offset(24.scale))
                }
                
                if !dashboard.courses.isEmpty {
                    elementsSection1.append(.title("MeditationsDashboard.Courses.Title".localized))
                    elementsSection1.append(.offset(8.scale))
                    elementsSection1.append(.subTitle("MeditationsDashboard.Courses.SubTitle".localized))
                    elementsSection1.append(.offset(16.scale))
                    
                    dashboard.courses.enumerated().forEach { index, course in
                        elementsSection1.append(.course(course))
                        
                        if index != (dashboard.courses.count - 1) {
                            elementsSection1.append(.offset(12.scale))
                        }
                    }
                    
                    elementsSection1.append(.offset(24.scale))
                }
                
                if !dashboard.groupes.isEmpty {
                    dashboard.groupes.forEach { group in
                        elementsSection2.append(.title(group.title))
                        
                        group.audios.forEach { audio in
                            elementsSection2.append(.audio(audio))
                        }
                    }
                }
                
                result.append(MeditationDashboardCollectionSection(elements: elementsSection1))
                result.append(MeditationDashboardCollectionSection(elements: elementsSection2))
                
                return result
            }
    }
}
