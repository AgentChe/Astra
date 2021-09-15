//
//  BiorhythmsViewModel.swift
//  Astra
//
//  Created by Andrey Chernyshev on 14.09.2021.
//

import RxSwift
import RxCocoa

final class BiorhythmsViewModel {
    lazy var elements = makeElements()
    
    private lazy var biorhythmsManager = BiorhythmsManagerCore()
}

// MARK: Private
private extension BiorhythmsViewModel {
    func makeElements() -> Driver<[BiorhythmsTableElement]> {
        biorhythmsManager.obtainBiorhythms()
            .map { biorhythms -> [BiorhythmsTableElement] in
                guard let biorhythms = biorhythms else {
                    return []
                }
                
                var result = [BiorhythmsTableElement]()
                
                result.append(.offset(23.scale))
                
                let chart = BiorhythmsTableChartElement(physical: biorhythms.physical.percentsGraph,
                                                        emotional: biorhythms.emotional.percentsGraph,
                                                        intellectual: biorhythms.intellectual.percentsGraph)
                result.append(.chart(chart))
                result.append(.offset(24.scale))
                
                result.append(.whatAreButton)
                result.append(.offset(24.scale))
                
                let physical = BiorhythmsTableComponentElement(name: "Biorhythms.Physical".localized,
                                                               percent: biorhythms.physical.percent,
                                                               text: biorhythms.physical.text)
                result.append(.component(physical))
                result.append(.offset(16.scale))
                
                let emotional = BiorhythmsTableComponentElement(name: "Biorhythms.Emotional".localized,
                                                                percent: biorhythms.emotional.percent,
                                                                text: biorhythms.emotional.text)
                result.append(.component(emotional))
                result.append(.offset(16.scale))
                
                let intellectual = BiorhythmsTableComponentElement(name: "Biorhythms.Intellectual".localized,
                                                                   percent: biorhythms.intellectual.percent,
                                                                   text: biorhythms.intellectual.text)
                result.append(.component(intellectual))
                result.append(.offset(16.scale))
                
                return result
            }
            .asDriver(onErrorJustReturn: [])
    }
}
