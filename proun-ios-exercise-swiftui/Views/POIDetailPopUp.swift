//
//  POIDetailPopUp.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 3/9/21.
//

import SwiftUI
protocol POIDetailPopUpDelegate {
    func showDetailPopUp(with poi: POIModel)
}

struct POIDetailPopUp: View {
    
    @ObservedObject var viewModel: POIViewModel
    
    var body: some View {
        VStack {
            HStack {
                
            }
        }
    }
}

struct POIDetailPopUp_Previews: PreviewProvider {
    static var previews: some View {
        POIDetailPopUp(viewModel: POIViewModel())
    }
}

