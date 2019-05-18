

import UIKit
import MapKit

class ALLInMap: UIViewController, MKMapViewDelegate  {
    @IBOutlet weak var mapView: MKMapView!
    var contentsList = [MKAnnotation]()
    var contents = [Features]()
    override func viewDidLoad() {
        super.viewDidLoad()
        contentsList = getContentsList(contents: contents)
        setMapRegion()
        mapView.addAnnotations(contentsList)
    }
    
    func setMapRegion() {
        let span = MKCoordinateSpan(latitudeDelta: 3, longitudeDelta: 3)
        let region = MKCoordinateRegion(center: (contentsList.last!.coordinate), span: span)
        mapView.setRegion(region, animated: true)
        mapView.regionThatFits(region)
    }
    
    func getContentsList(contents: [Features]) -> [MKAnnotation] {
        var annotationList = [MKAnnotation]()
        for content in contents {
            let annotation = MKPointAnnotation()
            annotation.title = content.properties.name
            annotation.subtitle = "個數：\(content.properties.count)"
            annotation.coordinate.latitude = content.geometry.coordinates[1]
            annotation.coordinate.longitude = content.geometry.coordinates[0]
            annotationList.append(annotation)
        }
        return annotationList
    }

}
