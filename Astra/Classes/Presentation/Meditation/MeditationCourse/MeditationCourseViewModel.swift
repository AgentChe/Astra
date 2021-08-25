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
    
    private lazy var meditationManager = MeditationManagerCore()
}

// MARK: Private
private extension MeditationCourseViewModel {
    func makeElements() -> Driver<[MeditationCourseTableElement]> {
        courseId
            .compactMap { $0 }
            .flatMapLatest { [weak self] courseId -> Single<MeditationCourseDetails?> in
                guard let self = self else {
                    return .never()
                }
                
                return self.meditationManager
                    .obtainCourseDetails(courseId: courseId)
            }
            .asDriver(onErrorJustReturn: nil)
            .map { course -> [MeditationCourseTableElement] in
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
                                                               number: index + 1)
                    result.append(.audio(element))
                    
                    if index != (course.audios.count - 1) {
                        result.append(.offset(14.scale))
                    }
                }
                
                return result
            }
    }
}
