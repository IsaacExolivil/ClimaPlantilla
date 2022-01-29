import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var SearchTextField: UITextField!
    
    var weatherManager =  WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchTextField.delegate = self
        
    }

    @IBAction func SearchPressed(_ sender: UIButton) {
        SearchTextField.endEditing(true)
        print(SearchTextField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        SearchTextField.endEditing(true)
        print(SearchTextField.text!)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = SearchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        SearchTextField.text = ""
    }
    
    
}



