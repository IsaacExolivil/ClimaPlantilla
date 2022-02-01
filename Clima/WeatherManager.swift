//
//  WeatherManager.swift
//  Clima
//
//  Created by Isaac on 28/01/22.

//

import Foundation

protocol WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    
}

struct WeatherManager {
    let climaUrl = "https://api.openweathermap.org/data/2.5/weather?&appid=d82109de35cd54ad77e2513f3bc961dc&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(climaUrl)&q=\(cityName)"
       perfomRequest(urlString: urlString)
    }
    
    
    
    
    func perfomRequest(urlString: String) {
        // Hacemos los 4 pasos
        
        //1.Crear un URL
        if let url = URL(string: urlString) {
            //2. Create a URLSession
            
            let session = URLSession(configuration: .default)
            //3. Darle la session una tarea
            let task = session.dataTask(with: url) {(data, response, error)
                in
                
                if error != nil{
                   
                    print(error)
                    return
                }
                if let safeData = data {
                    if  let weather = self.parseJSON(weatherData: safeData) {
                        delegate?.didUpdateWeather(self, weather: weather)
                    }
                 
                  
                }
                
            }
            //4. empezar la tarea
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let idApi = decodedData.id
            let nameApi = decodedData.name
            let weather = WeatherModel(id: idApi , cityName: nameApi)
            return weather
            

        } catch {
            print(error)
            return nil
        }
    }
}
