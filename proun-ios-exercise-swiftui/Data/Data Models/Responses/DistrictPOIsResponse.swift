//
//  PoisResponse.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 1/9/21.
//

import Foundation

class DistrictPOIsResponse: BaseModel {
    
    var poisCount: Int?
    var eventsCount: Int?
    var id: Int?
    var name: String?
    var image: MediaModel?
    var galleryImages: [MediaModel]?
    var coordinates: String?
    var isFree: Bool?
    var video: MediaModel?
    var audio: MediaModel?
    var pois: [POIModel]?
    
    private enum CodingKeys: String, CodingKey {
        case poisCount = "pois_count"
    }
    
    
}
