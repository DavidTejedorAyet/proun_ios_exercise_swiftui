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
        case eventsCount = "events_count"
        case id
        case name
        case image
        case galleryImages = "gallery_images"
        case coordinates
        case isFree = "is_free"
        case video
        case audio
        case pois
    }
    
    
}
