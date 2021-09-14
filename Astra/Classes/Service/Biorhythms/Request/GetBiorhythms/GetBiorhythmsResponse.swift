//
//  GetBiorhythmsResponse.swift
//  Astra
//
//  Created by Andrey Chernyshev on 14.09.2021.
//

final class GetBiorhythmsResponse {
    static func map(from response: Any) -> Biorhythms? {
        guard
            let json = response as? [String: Any],
            let data = json["_data"] as? [String: Any],
            let physicalJSON = data["physical"] as? [String: Any],
            let emotionalJSON = data["emotional"] as? [String: Any],
            let intellectualJSON = data["intellectual"] as? [String: Any]
        else {
            return nil
        }
        
        guard
            let physical = mapBiorhytm(biorhythmJSON: physicalJSON),
            let emotional = mapBiorhytm(biorhythmJSON: emotionalJSON),
            let intellectual = mapBiorhytm(biorhythmJSON: intellectualJSON)
        else {
            return nil
        }
        
        return Biorhythms(physical: physical,
                          emotional: emotional,
                          intellectual: intellectual)
    }
}

// MARK: Private
private extension GetBiorhythmsResponse {
    static func mapBiorhytm(biorhythmJSON: [String: Any]) -> Biorhythm? {
        guard
            let percent = biorhythmJSON["percent"] as? Double,
            let text = biorhythmJSON["text"] as? String,
            let percentsGraph = biorhythmJSON["percents_graph"] as? [Double]
        else {
            return nil
        }
        
        return Biorhythm(percent: percent,
                         text: text,
                         percentsGraph: percentsGraph)
    }
}
