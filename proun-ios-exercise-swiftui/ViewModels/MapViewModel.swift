//
//  MapViewModel.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 2/9/21.
//

import SwiftUI
import MapKit

class MapViewModel: NSObject, ObservableObject, MKMapViewDelegate {
    
    @Published var anotations: [MKPointAnnotation] = []
    @Published var districtPoints: [CLLocationCoordinate2D] = []
    @Published var districtPolyline: MKPolyline?
    @Published var districtPolygon: MKPolygon?

    var districtCoordinates: String = ""
    var pois: [POIModel] = []

    func setMap() {
        if districtCoordinates.isEmpty || pois.isEmpty  { return }
        
        self.districtPoints = getDistrictCoordinates(string: districtCoordinates)
        self.districtPolyline = MKPolyline(coordinates: districtPoints, count: districtPoints.count)
        self.districtPolygon =  MKPolygon(coordinates: districtPoints, count: districtPoints.count)
        self.anotations = getMapAnotations(pois: pois)

       
        
    }
    
    
    func getDistrictCoordinates(string: String) -> [CLLocationCoordinate2D] {
        var points: [CLLocationCoordinate2D] = []
        var stringCoordinates = string.components(separatedBy: ",0.0")
        stringCoordinates.removeLast()
        
        for stringCoordinate in stringCoordinates {
            let splitCoordinates = stringCoordinate.replacingOccurrences(of: " ", with: "") .components(separatedBy: ",")
            let point = CLLocationCoordinate2D(latitude: Double(splitCoordinates.last ?? "0.0") ?? 0.0, longitude: Double(splitCoordinates.first ?? "0.0") ?? 0.0)
            points.append(point)
        }
        return points
    }
    
    func getMapAnotations(pois: [POIModel]) -> [MKPointAnnotation]{
        var anotations: [MKPointAnnotation] = []
        
        for poi in pois {
            let anotation = MKPointAnnotation()
            let coordinates = CLLocationCoordinate2D(latitude: poi.latitude ?? 0.0, longitude:poi.longitude ?? 0.0)
            anotation.coordinate = coordinates
            anotations.append(anotation)
        }
        return anotations
    }
    

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {

        if let overlay = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: overlay)
            renderer.strokeColor = .white
            renderer.lineWidth = 4
            renderer.lineDashPattern = [0,10]

            return renderer
        } else if let overlay = overlay as? MKPolygon{
            let renderer = MKPolygonRenderer(polygon: overlay)
            renderer.fillColor = UIColor.orange.withAlphaComponent(0.25)
            return renderer
        } else {
            return MKOverlayRenderer(overlay: overlay)
        }
    }
}
