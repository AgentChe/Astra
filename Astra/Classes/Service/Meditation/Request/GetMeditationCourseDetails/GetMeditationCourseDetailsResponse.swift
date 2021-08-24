//
//  GetMeditationCourseDetailsResponse.swift
//  Astra
//
//  Created by Andrey Chernyshev on 24.08.2021.
//

final class GetMeditationCourseDetailsResponse {
    static func map(from response: Any) -> MeditationCourseDetails? {
        guard
            let json = response as? [String: Any],
            let data = json["_data"] as? [String: Any],
            let courseJSON = data["course"] as? [String: Any]
        else {
            return nil
        }
        
        guard
            let title = courseJSON["title"] as? String,
            let description = courseJSON["description"] as? String,
            let longDescription = courseJSON["long_description"] as? String,
            let imageUrl = courseJSON["image_url"] as? String,
            let meditationsArray = courseJSON["meditations"] as? [[String: Any]]
        else {
            return nil
        }
        
        let audios = meditationsArray.compactMap { audioJSON -> MeditationAudio? in
            guard
                let id = audioJSON["id"] as? Int,
                let title = audioJSON["title"] as? String,
                let duration = audioJSON["duration"] as? Int,
                let imageUrl = audioJSON["image_url"] as? String,
                let audioUrl = audioJSON["audio_url"] as? String,
                let paid = audioJSON["paid"] as? Bool
            else {
                return nil
            }
            
            return MeditationAudio(id: id,
                                   title: title,
                                   duration: duration,
                                   imageUrl: imageUrl,
                                   audioUrl: audioUrl,
                                   paid: paid)
        }
        
        return MeditationCourseDetails(title: title,
                                       description: description,
                                       longDescription: longDescription,
                                       imageUrl: imageUrl,
                                       audios: audios)
    }
}
