//
//  MapView.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 2/9/21.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
//    @Binding var points: [POIModel]
    @Binding var pois: [POIModel]
    @Binding var districtCoordinates: String

    var viewModel: MapViewModel = MapViewModel()
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.delegate = viewModel
        
        mapView.mapType = .hybridFlyover
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
//        let coordinate = CLLocationCoordinate2D(latitude: 40.130176, longitude: -8.2012655)
//        let span = MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 20)
//        let region = MKCoordinateRegion(center: coordinate, span: span)
//
//        uiView.setRegion(region, animated: true)
//        viewModel.points = self.points
        viewModel.pois = self.pois
        viewModel.districtCoordinates = districtCoordinates
        
        viewModel.setMap()

        drawDistrictArea(in: uiView)
        drawPOIs(in: uiView)
        
    }
    
    func drawDistrictArea(in view: MKMapView) {
        if !view.overlays.isEmpty {
            view.removeOverlays(view.overlays)
        }
        
        guard let polyline = viewModel.districtPolyline else { return }
        guard let polygon = viewModel.districtPolygon else { return }

        let mapRect = polyline.boundingMapRect
        view.setVisibleMapRect(mapRect, edgePadding: UIEdgeInsets(top: 40, left: 40, bottom: 10, right: 10), animated: true)

        view.addOverlay(polygon)
        view.addOverlay(polyline)

    }
    
    func drawPOIs(in view: MKMapView) {
        view.removeAnnotations(view.annotations)
        view.addAnnotations(viewModel.anotations)
        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(pois: .constant([]), districtCoordinates: .constant(""))
    }
}
