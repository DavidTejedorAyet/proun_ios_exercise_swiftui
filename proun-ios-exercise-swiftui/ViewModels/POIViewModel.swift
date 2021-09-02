//
//  POIViewModel.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 1/9/21.
//

import Foundation

class POIViewModel: ObservableObject {
    
    let requestManager = RequestManager()
    
    init() {
//        downloadData()
        
    }
    
    func downloadData() {
        requestManager.getDistrictPOIs() {
            response in
            print(response)
        }
    }
}
