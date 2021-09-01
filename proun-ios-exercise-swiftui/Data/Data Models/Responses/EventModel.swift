//
//  EventModel.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 1/9/21.
//

import Foundation

class EventModel: BaseModel {
    var id: Int?
    var fromDatetime: String?
    var toDatetime: String?
    var category: CategoryModel?
    var externalLink: String?
    var poi: POIModel?
    var latitude: Double?
    var longitude: Double?
    var isFeatured: Bool?
    var galleryImages: [MediaModel]?
    var title: String?
    var description: String?
    var place: String?
    var address: String?
    var isLiked: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case fromDatetime = "from_datetime"
        case toDatetime = "to_datetime"
        case category
        case externalLink = "external_link"
        case poi
        case latitude
        case longitude
        case isFeatured = "featured"
        case galleryImages = "gallery_images"
        case title
        case description
        case place
        case address
        case isLiked
    }
}
