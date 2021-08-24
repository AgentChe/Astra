//
//  GetMeditationDashboardResponse.swift
//  Astra
//
//  Created by Andrey Chernyshev on 24.08.2021.
//

final class GetMeditationDashboardResponse {
    static func map(from response: Any) -> MeditationDashboard? {
        guard
            let json = response as? [String: Any],
            let data = json["_data"] as? [String: Any],
            let dashboardJSON = data["dashboard"] as? [String: Any]
        else {
            return nil
        }
        
        let daily = daily(from: dashboardJSON)
        let courses = courses(from: dashboardJSON)
        let groupes = groupes(from: dashboardJSON)
        
        return MeditationDashboard(daily: daily,
                                   courses: courses,
                                   groupes: groupes)
    }
}

// MARK: Private
private extension GetMeditationDashboardResponse {
    static func daily(from json: [String: Any]) -> DailyMeditation? {
        guard let dailyMeditationJSON = json["daily_meditation"] as? [String: Any] else {
            return nil
        }
        
        guard
            let id = dailyMeditationJSON["id"] as? Int,
            let date = dailyMeditationJSON["date"] as? String,
            let title = dailyMeditationJSON["title"] as? String,
            let duration = dailyMeditationJSON["duration"] as? Int,
            let imageUrl = dailyMeditationJSON["image_url"] as? String,
            let audioUrl = dailyMeditationJSON["audio_url"] as? String,
            let paid = dailyMeditationJSON["paid"] as? Bool
        else {
            return nil
        }
        
        let audio = MeditationAudio(id: id,
                                    title: title,
                                    duration: duration,
                                    imageUrl: imageUrl,
                                    audioUrl: audioUrl,
                                    paid: paid)
        
        return DailyMeditation(date: date,
                               audio: audio)
    }
    
    static func courses(from json: [String: Any]) -> [MeditationCourse] {
        guard let coursesArray = json["courses"] as? [[String: Any]] else {
            return []
        }
        
        return coursesArray.compactMap { courseJSON -> MeditationCourse? in
            guard
                let id = courseJSON["id"] as? Int,
                let title = courseJSON["title"] as? String,
                let description = courseJSON["description"] as? String,
                let count = courseJSON["count"] as? Int,
                let imageUrl = courseJSON["image_url"] as? String
            else {
                return nil
            }
            
            return MeditationCourse(id: id,
                                    title: title,
                                    description: description,
                                    count: count,
                                    imageUrl: imageUrl)
        }
    }
    
    static func groupes(from json: [String: Any]) -> [MeditationGroup] {
        guard let coursesArray = json["meditations"] as? [[String: Any]] else {
            return []
        }
        
        return coursesArray.compactMap { courseJSON -> MeditationGroup? in
            guard
                let title = courseJSON["label_name"] as? String,
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
            
            return MeditationGroup(title: title,
                                   audios: audios)
        }
    }
}
