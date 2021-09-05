//
//  POIViewModel.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 1/9/21.
//

import Foundation

class POIViewModel: ObservableObject {
    
    let requestManager = RequestManager()
    
    var pois: [POIModel] = []
    var districtCoordinates = ""
    var districtName = ""
    var poisCount = ""
    var selectedPOI: POIModel?
    
    @Published var isLoading: Bool = false
    @Published var showPopUp = false
    
    init() {
        downloadData()
    }
    
    func downloadData() {
        isLoading = true
        
        requestManager.getDistrictPOIs() {
            response in
            switch response {
            case .success(let data):
                self.pois = data.pois ?? []
                self.districtCoordinates = data.coordinates ?? ""
                self.districtName = data.name ?? ""
                self.poisCount = String(data.poisCount ?? 0)
                self.isLoading = false
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
