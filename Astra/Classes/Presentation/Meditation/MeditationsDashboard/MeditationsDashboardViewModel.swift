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
    lazy var sections = makeSections()
    
    lazy var didSelectFilter = PublishRelay<MeditationsFilterCollectionElement>()
    
    private lazy var dashboard = makeDashboard()
    private lazy var activeSubscription = makeActiveSubscription()
    
    private lazy var meditationManager = MeditationManagerCore()
    private lazy var sessionManager = SessionManager()
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
    
    func makeSections() -> Driver<[MeditationDashboardCollectionSection]> {
        let sections = Driver.combineLatest(dashboard, activeSubscription)
            .map { dashboard, activeSubscription -> [MeditationDashboardCollectionSection] in
                var result = [MeditationDashboardCollectionSection]()
                
                if let daily = dashboard.daily {
                    let elements: [MeditationDashboardCollectionElement] = [
                        .daily(MeditationDashboardCollectionDailyElement(daily: daily,
                                                                         needPayment: activeSubscription ? false : daily.audio.paid)),
                        .offset(24.scale)
                    ]
                    let section = MeditationDashboardCollectionSection(code: .daily,
                                                                       elements: elements)
                    result.append(section)
                }
                
                if !dashboard.courses.isEmpty {
                    var elements: [MeditationDashboardCollectionElement] = [
                        .title("MeditationsDashboard.Courses.Title".localized),
                        .offset(8.scale),
                        .subTitle("MeditationsDashboard.Courses.SubTitle".localized),
                        .offset(16.scale)
                    ]
                    
                    dashboard.courses.enumerated().forEach { index, course in
                        elements.append(.course(course))
                        
                        if index != (dashboard.courses.count - 1) {
                            elements.append(.offset(12.scale))
                        }
                    }
                    
                    elements.append(.offset(24.scale))
                    
                    let section = MeditationDashboardCollectionSection(code: .courses,
                                                                       elements: elements)
                    result.append(section)
                }
                
                if !dashboard.groupes.isEmpty {
                    dashboard.groupes.forEach { group in
                        var elements: [MeditationDashboardCollectionElement] = []
                        
                        elements.append(.title(group.title))
                        
                        group.audios.forEach { audio in
                            elements.append(.audio(MeditationDashboardCollectionAudioElement(audio: audio,
                                                                                             needPayment: activeSubscription ? false : audio.paid)))
                        }
                        
                        elements.append(.offset(12.scale))
                        
                        let section = MeditationDashboardCollectionSection(code: .group(group.title),
                                                                           elements: elements)
                        result.append(section)
                    }
                }
                
                return result
            }
        
        let result = Driver
            .combineLatest(
                didSelectFilter
                    .map { $0.code}
                    .asDriver(onErrorDriveWith: .empty())
                    .startWith(.all),
                
                sections
            ) { code, sections -> [MeditationDashboardCollectionSection] in
                switch code {
                case .all:
                    return sections
                case .courses:
                    return sections.filter { section -> Bool in
                        guard case .courses = section.code else {
                            return false
                        }
                        
                        return true
                    }
                case .another(let name):
                    return sections.filter { section -> Bool in
                        guard case let .group(groupName) = section.code, groupName == name else {
                            return false
                        }
                        
                        return true
                    }
                }
            }
        
        return result
    }
    
    func makeActiveSubscription() -> Driver<Bool> {
        PurchaseValidationObserver.shared
            .didValidatedWithActiveSubscription
            .map { SessionManager().hasActiveSubscriptions() }
            .asDriver(onErrorJustReturn: false)
            .startWith(SessionManager().hasActiveSubscriptions())
    }
}
