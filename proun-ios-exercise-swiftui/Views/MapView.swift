//
//  MapView.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 2/9/21.
//

import SwiftUI
import GoogleMaps

struct MapView: UIViewRepresentable {
    
    @Binding var pois: [POIModel]
    @Binding var districtCoordinates: String

    var detailPopUpDelegate: POIDetailPopUpDelegate?
    var viewModel: MapViewModel = MapViewModel()
    
    func makeUIView(context: Context) -> GMSMapView {

        let mapView = GMSMapView(frame: .zero)
        changeMapStyle(mapView: mapView)
        return mapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        uiView.delegate = viewModel

        uiView.clear()
        
        viewModel.detailPopUpDelegate = detailPopUpDelegate
        viewModel.pois = self.pois
        viewModel.districtCoordinates = districtCoordinates
        
        viewModel.setMap()
        
        centerMap(uiView)
        drawDistrictArea(in: uiView)
        drawPOIs(in: uiView)
        
    }
    
    func centerMap(_ view: GMSMapView) {
        let bounds = GMSCoordinateBounds(path: viewModel.path ?? GMSMutablePath())
        let camera: GMSCameraUpdate = GMSCameraUpdate.fit(bounds)
        view.animate(with: camera)
    }
    
    func drawDistrictArea(in view: GMSMapView) {
       
        guard let polyline = viewModel.districtPolyline else { return }
        guard let polygon = viewModel.districtPolygon else { return }

        polygon.fillColor = UIColor(named: "PrimaryColor")?.withAlphaComponent(0.35)
        
        let styles = [GMSStrokeStyle.solidColor(.clear),
                              GMSStrokeStyle.solidColor(.white)]

        let lengths: [NSNumber] = [20, 20]
        polyline.spans = GMSStyleSpans(polyline.path!, styles, lengths, .rhumb)
        polyline.strokeWidth = 5
        polygon.map = view
        polyline.map = view
        
    }

    func drawPOIs(in view: GMSMapView) {
        for marker in viewModel.markers {
            marker.map = view
        }
    }
    
    func changeMapStyle(mapView: GMSMapView){
        do {
            if let styleURL = Bundle.main.url(forResource: "mapStyle", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            print("One or more of the map styles failed to load. \(error)")
        }
        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(pois: .constant([]), districtCoordinates: .constant(""))
    }
}
