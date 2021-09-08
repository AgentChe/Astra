//
//  MeditationCourseViewModel.swift
//  Astra
//
//  Created by Andrey Chernyshev on 25.08.2021.
//

import RxSwift
import RxCocoa

final class MeditationCourseViewModel {
    lazy var elements = makeElements()
    
    lazy var courseId = BehaviorRelay<Int?>(value: nil)
    
    private lazy var activeSubscription = makeActiveSubscription()
    
    private lazy var meditationManager = MeditationManagerCore()
    private lazy var sessionManager = SessionManagerCore()
}

// MARK: Private
private extension MeditationCourseViewModel {
    func makeElements() -> Driver<[MeditationCourseTableElement]> {
        let course = courseId
            .compactMap { $0 }
            .flatMapLatest { [weak self] courseId -> Single<MeditationCourseDetails?> in
                guard let self = self else {
                    return .never()
                }
                
                return self.meditationManager
                    .obtainCourseDetails(courseId: courseId)
            }
            .asDriver(onErrorJustReturn: nil)
            
        return Driver.combineLatest(course, activeSubscription)
            .map { course, activeSubscription -> [MeditationCourseTableElement] in
                guard let course = course else {
                    return []
                }
                
                var result = [MeditationCourseTableElement]()
                
                result.append(.header(imagePath: course.imageUrl,
                                      title: course.title,
                                      info: course.description))
                result.append(.offset(16.scale))
                
                result.append(.text(course.longDescription))
                result.append(.offset(30.scale))
                
                course.audios.enumerated().forEach { index, audio in
                    let element = MeditationCourseAudioElement(audio: audio,
                                                               number: index + 1,
                                                               needPayment: activeSubscription ? false : audio.paid)
                    result.append(.audio(element))
                    
                    if index != (course.audios.count - 1) {
                        result.append(.offset(14.scale))
                    }
                }
                
                return result
            }
    }
    
    func makeActiveSubscription() -> Driver<Bool> {
        let updated = SDKStorage.shared
            .purchaseMediator
            .rxPurchaseMediatorDidValidateReceipt
            .compactMap { $0?.activeSubscription }
            .asDriver(onErrorJustReturn: false)
        
        let initial = Driver<Bool>
            .deferred { [weak self] in
                guard let this = self else {
                    return .never()
                }
                
                let activeSubscription = this.sessionManager.getSession()?.activeSubscription ?? false
                
                return .just(activeSubscription)
            }
        
        return Driver
            .merge(initial, updated)
    }
}
