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
    @Published var districtName = ""
    @Published var poisCount = ""
     
    @Published var showPopUp = false
    @Published var selectedPOI: POIModel?
    
    func downloadData() {
        requestManager.getDistrictPOIs() {
            response in
            switch response {
            case .success(let data):
                self.pois = data.pois ?? []
                self.districtCoordinates = data.coordinates ?? ""
                self.districtName = data.name ?? ""
                self.poisCount = String(data.poisCount ?? 0)
            case .error(let error):
                print("*** \(error.localizedDescription)")
            }
        }
    }
}

extension POIViewModel : POIDetailPopUpDelegate {
    func showDetailPopUp(with poi: POIModel) {
        showPopUp.toggle()
        self.selectedPOI = poi
    }
}
