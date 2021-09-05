//
//  MapView.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 2/9/21.
//

import SwiftUI
import GoogleMaps

struct MapView: UIViewRepresentable {
    
    var viewModel: MapViewModel
    
    func makeUIView(context: Context) -> GMSMapView {
        
        let mapView = GMSMapView(frame: .zero)
        changeMapStyle(mapView: mapView)
        return mapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        uiView.delegate = viewModel
        uiView.clear()
        
        if viewModel.isDetailMap {
            centerMapOn(coordinates: viewModel.markers.first?.position ?? CLLocationCoordinate2D(), mapView: uiView)
            uiView.isUserInteractionEnabled = false
            
        } else {
            centerMapOn(path: viewModel.path ?? GMSMutablePath(),mapView: uiView)
            drawDistrictArea(in: uiView)
        }
        
        drawPOIs(in: uiView)
        
    }
    
    func centerMapOn(path: GMSMutablePath, mapView: GMSMapView) {
        let bounds = GMSCoordinateBounds(path: path)
        let camera: GMSCameraUpdate = GMSCameraUpdate.fit(bounds)
        mapView.animate(with: camera)
    }
    
    func centerMapOn(coordinates: CLLocationCoordinate2D, mapView: GMSMapView) {
        let camera = GMSCameraPosition(latitude: coordinates.latitude, longitude: coordinates.longitude, zoom: 13)
        mapView.camera = camera
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
                NSLog("Unable to find mapStyle.json")
            }
        } catch {
            print("One or more of the map styles failed to load. \(error)")
        }
        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(viewModel: MapViewModel(selectedPOI: POIModel()))
    }
}
