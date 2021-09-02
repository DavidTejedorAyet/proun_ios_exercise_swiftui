//
//  POIViewModel.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 1/9/21.
//

import Foundation

class POIViewModel: ObservableObject {
    
    let requestManager = RequestManager()
    @Published var pois: [POIModel] = []
    @Published var districtCoordinates = ""
    
    init() {
//        downloadData()
        
    }
    
    func downloadData() {
        requestManager.getDistrictPOIs() {
            response in
            switch response {
            case .success(let data):
                self.pois = data.pois ?? []
                self.districtCoordinates = data.coordinates ?? ""
            case .error(let error):
                print("*** \(error.localizedDescription)")
            }
        }
    }
}
