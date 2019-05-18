

import UIKit

class StarSearch: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    @IBOutlet weak var tf_searchContent: UITextField!
    @IBOutlet weak var pv_time: UIPickerView!
    @IBOutlet weak var tv_notice: UITextView!
    let hours = ["1h","2h","4h","6h","12h"]
    let days = ["0d","1d","2d","3d","4d","5d","6d"]
    var time = [[String]]()
    var urlString:String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tv_notice.text = """
        使用方法：
        輸入你想要收尋的內容和時間(英文)
        (ex: trump  時間: 默認24小時)
        即得各區域時間內輸入此關鍵字人數＆貼文
        
        注意事項：
        免責聲明,本APP僅供參考使用
        如有利用此APP做出任何違法行為,請自行負責
        """
        time.append(days)
        time.append(hours)
    }

    @IBAction func btn_star(_ sender: Any) {
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return time.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return time[component].count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return time[component][row];
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let searchcontentTCV = segue.destination as! SearchContentTVC
        searchcontentTCV.urlString = urlString
        searchcontentTCV.title = tf_searchContent.text
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let search = tf_searchContent.text ?? ""
        if search != "" {
            let url = "https://api.gdeltproject.org/api/v2/geo/geo?query=" + search + "&format=GeoJSON"
            urlString = url
            return true
            
        }else{
            let error = UIAlertController(title: "輸入錯誤", message: "請再次輸入", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "確認", style: .cancel, handler: nil)
            error.addAction(okAction)
            present(error, animated: true, completion: nil)
            return false
        }
    }
}

