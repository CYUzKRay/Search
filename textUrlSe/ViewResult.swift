

import UIKit
import MapKit

class ViewResult: UIViewController, MKMapViewDelegate   {
    @IBOutlet weak var im_image: UIImageView!
    @IBOutlet weak var tv_result: UITextView!
    @IBOutlet weak var mp_map: MKMapView!
    var result:Features!
    var content = [MKAnnotation]()
    override func viewDidLoad() {
        super.viewDidLoad()
        content = getContent(content: result)
        setMapRegion()
        mp_map.addAnnotations(content)
        
        tv_result.text = "name: \(result.properties.name)\ncount: \(result.properties.count)\nlatitude: \(result.geometry.coordinates[1])\nlongitude: \(result.geometry.coordinates[0])"
        
        let url = URL(string: result.properties.shareimage ?? "https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png")
        let task = URLSession.shared.dataTask(with: url ?? URL(string: "https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png")!) {[weak self] (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    self?.im_image.image = UIImage(data: data)
                }
            }
        }
        task.resume()
    }
    
    
    func setMapRegion() {
        let span = MKCoordinateSpan(latitudeDelta: 3, longitudeDelta: 3)
        let region = MKCoordinateRegion(center: (content.last!.coordinate), span: span)
        mp_map.setRegion(region, animated: true)
        mp_map.regionThatFits(region)
    }
    
    func getContent(content: Features) -> [MKAnnotation] {
        var annotationList = [MKAnnotation]()
        let annotation = MKPointAnnotation()
        annotation.title = content.properties.name
        annotation.subtitle = "個數：\(content.properties.count)"
        annotation.coordinate.latitude = content.geometry.coordinates[1]
        annotation.coordinate.longitude = content.geometry.coordinates[0]
        annotationList.append(annotation)
        
        return annotationList
    }
}
