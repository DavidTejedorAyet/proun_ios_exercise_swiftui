//
//  MapViewModel.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 2/9/21.
//

import SwiftUI
import UIKit
import GoogleMaps

class MapViewModel: NSObject, ObservableObject, GMSMapViewDelegate {
    
    @Published var markers: [GMSMarker] = []
    @Published var districtPoints: [CLLocationCoordinate2D] = []
    @Published var districtPolyline: GMSPolyline?
    @Published var districtPolygon: GMSPolygon?
    @Published var path: GMSMutablePath?
    
    var districtCoordinates: String = ""
    var pois: [POIModel] = []

    func setMap() {
        if districtCoordinates.isEmpty || pois.isEmpty  { return }
        
        self.districtPoints = getDistrictCoordinates(string: districtCoordinates)
        
        self.path = createPath(coordinates: districtPoints)
        self.districtPolyline = GMSPolyline(path: path)
        self.districtPolygon =  GMSPolygon(path: path)
        self.markers = createMapMarkers(pois: pois)
        
        
    }
    
    func createPath (coordinates: [CLLocationCoordinate2D]) -> GMSMutablePath {
        let path = GMSMutablePath()
        for coordinate in coordinates {
            path.add(coordinate)
        }
        return path
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
    
    func createMapMarkers(pois: [POIModel]) -> [GMSMarker]{
        var markers: [GMSMarker] = []
        
        for poi in pois {
            let marker = GMSMarker()
            let coordinates = CLLocationCoordinate2D(latitude: poi.latitude ?? 0.0, longitude:poi.longitude ?? 0.0)
            
            marker.position = coordinates
            markers.append(marker)
            let imageURL = URL(string: poi.category?.marker?.url ?? "")!
            applyImage(from: imageURL, to: marker)
            
            
        }
        return markers
    }
    
    func applyImage(from url: URL, to marker: GMSMarker) {
        DispatchQueue.global(qos: .background).async {
            guard let data = try? Data(contentsOf: url),
                let image = UIImage(data: data)
                else { return }

            DispatchQueue.main.async {
                marker.icon = image
            }
        }
    }

  
}
