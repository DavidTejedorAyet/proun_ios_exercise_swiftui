//
//  MediaModel.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 1/9/21.
//

import Foundation

//Imagenes, audios o videos

class MediaModel: BaseModel {
    var name: String?
    var description: String?
    var width: String?
    var height: String?
    var size: Double?
    var id: Int?
    var url: String?
    
    private enum CodingKeys: String, CodingKey {
        case name
        case description
        case width
        case height
        case size
        case id
        case url
    }
}
