

import UIKit

class SearchContentTVC: UITableViewController {
    
    var urlString: String! = nil
    var contents = [Features]()
    let activityIndicatorView = UIActivityIndicatorView(style: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(activityIndicatorView)
        activityIndicatorView.center = view.center
        activityIndicatorView.startAnimating()
        
        if let urlS = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),let url = URL(string: urlS){
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data{
                    let decoder = JSONDecoder()
                    
                    do{
                        let contentResults = try decoder.decode(Searchcontent.self, from: data)
                        self.contents = contentResults.features
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            self.activityIndicatorView.removeFromSuperview()
                        }
                    }
                    catch{
                        print(error)
                    }
                }
            }
            task.resume()
        }
     
    }

    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchContentCell", for: indexPath) as! SearchContentCell
        
        let content = contents[indexPath.row]
        
        cell.lb_name.text = content.properties.name
        cell.lb_count.text = "區域個數\(content.properties.count)"
        let url = URL(string: content.properties.shareimage ?? "https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png")
        let task = URLSession.shared.dataTask(with: url ?? URL(string: "https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png")!) {[weak cell] (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    cell?.im_image.image = UIImage(data: data)
                }
            }
        }
        task.resume()
        
        return cell
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seeMap" {
            let allInMap = segue.destination as! ALLInMap
            allInMap.contents = contents
        }
        if segue.identifier == "seeResult"{
            if let indexPath = tableView.indexPathForSelectedRow{
                let result = contents[indexPath.row]
                let viewResult = segue.destination as! ViewResult
                viewResult.result = result
            }
        }
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
