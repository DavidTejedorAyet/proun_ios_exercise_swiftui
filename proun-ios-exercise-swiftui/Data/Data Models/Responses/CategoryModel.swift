//
//  CategoryModel.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 1/9/21.
//

import Foundation

class CategoryModel: BaseModel {
    var id: Int?
    var icon: MediaModel?
    var marker: MediaModel?
    var markerIcon: MediaModel?
    var name: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case icon
        case marker
        case markerIcon = "marker_icon"
    }
}
