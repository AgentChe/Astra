//
//  GetBiorhythmsResponse.swift
//  Astra
//
//  Created by Andrey Chernyshev on 14.09.2021.
//

final class GetBiorhythmsResponse {
    // TODO
    static func map(from response: Any) -> Biorhythms? {
        let p = Biorhythm(percent: -94.23,
                          text: "Your are in a negative cycle for your physical attributes, which ends on Thursday, April 8th.  Your strength, coordination, and wellbeing may not be at their highest, so it is a good opportunity to work on them.",
                          percentsGraph: [0, -48, -90, -100, -95])
        
        let e = Biorhythm(percent: -78.18,
                          text: "Your are in a negative cycle for your physical attributes, which ends on Thursday, April 8th.  Your strength, coordination, and wellbeing may not be at their highest, so it is a good opportunity to work on them.",
                          percentsGraph: [-100, -70, -50, -10, 40])
        
        let i = Biorhythm(percent: 24.32,
                          text: "Your are in a negative cycle for your physical attributes, which ends on Thursday, April 8th.  Your strength, coordination, and wellbeing may not be at their highest, so it is a good opportunity to work on them.",
                          percentsGraph: [100, 80, 40, 20, -50])
        
        return Biorhythms(physical: p,
                          emotional: e,
                          intellectual: i)
    }

//    static func map(from response: Any) -> Biorhythms? {
//        guard
//            let json = response as? [String: Any],
//            let data = json["_data"] as? [String: Any],
//            let physicalJSON = data["physical"] as? [String: Any],
//            let emotionalJSON = data["emotional"] as? [String: Any],
//            let intellectualJSON = data["intellectual"] as? [String: Any]
//        else {
//            return nil
//        }
//
//        guard
//            let physical = mapBiorhytm(biorhythmJSON: physicalJSON),
//            let emotional = mapBiorhytm(biorhythmJSON: emotionalJSON),
//            let intellectual = mapBiorhytm(biorhythmJSON: intellectualJSON)
//        else {
//            return nil
//        }
//
//        return Biorhythms(physical: physical,
//                          emotional: emotional,
//                          intellectual: intellectual)
//    }
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
