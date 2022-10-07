//
//  MeditationCourseTableElement.swift
//  Astra
//
//  Created by Andrey Chernyshev on 25.08.2021.
//

import CoreGraphics

enum MeditationCourseTableElement {
    case offset(CGFloat)
    case header(imagePath: String, title: String, info: String)
    case text(String)
    case audio(MeditationCourseAudioElement)
}
