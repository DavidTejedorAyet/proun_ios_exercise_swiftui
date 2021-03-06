//
//  POIModel.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 1/9/21.
//

import Foundation

class POIModel: BaseModel {
    var likesCount: Int?
    var eventsCount: Int?
    var newsCount: Int?
    var id: Int?
    var name: String?
    var description: String?
    var image: MediaModel?
    var galleryImages: [MediaModel]?
    var latitude: Double?
    var longitude: Double?
    var category: CategoryModel?
    var isPremium: Bool?
    var events: [EventModel]?
    var audio: MediaModel?
    var isLiked: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case likesCount = "likes_count"
        case eventsCount = "events_count"
        case newsCount = "news_count"
        case id
        case name
        case description
        case image
        case galleryImages = "gallery_images"
        case latitude
        case longitude
        case category
        case isPremium = "premium"
        case events
        case audio
        case isLiked = "like_it"
        
    }
}
