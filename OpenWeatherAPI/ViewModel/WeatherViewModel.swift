//
//  WeatherViewModel.swift
//  OpenWeatherAPI
//
//  Created by Jianan Li on 12/9/22.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var weatherData : weatherDataModel = weatherDataModel()
    
    init() {
        //sendRequest()
    }
    
    func sendRequest() -> Void {
        // assemable url string
        var urlComponent = URLComponents(string: "https://api.openweathermap.org/data/2.5/weather")
        
        urlComponent?.queryItems = [
            URLQueryItem(name: "lat", value: "42.613852"),
            URLQueryItem(name: "lon", value: "-83.183901"),
            URLQueryItem(name: "appid", value: "417e9505238da90a0eb7a6a109c371b2")
        ]
        // string --> url
        let url = urlComponent?.url
        
        // url --> request
        var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        // update url method
        request.httpMethod = "GET"
        
        // create URL session
        let session = URLSession.shared
        
        // create dataTask
        let dataTask = session.dataTask(with: request) { data, response, error  in
            if error == nil, let data = data, let response = response as? HTTPURLResponse {
                print("no http error. process to check response code")
                if response.statusCode == 200 {
                    print("response code is 200. process to parse data")
                    
                    // to do. parse json data
                    do {
                        let jsondecoder = JSONDecoder()
                        
                        let decodedData = try jsondecoder.decode(weatherDataModel.self, from: data)
                        DispatchQueue.main.async {
                            self.weatherData = decodedData
                        }
                    } catch  {
                        print("can't decode json data")
                        print(error.localizedDescription)
                    }
                    
                }
                else{
                    print("receive some error")
                    print("\(response.statusCode)")
                }
            }
            else{
                print("error to send get request")
            }
        }
        dataTask.resume()
    }
    
    func sendRequest2() async throws -> weatherDataModel{
        var urlComponent = URLComponents(string: "https://api.openweathermap.org/data/2.5/weather")
        
        urlComponent?.queryItems = [
            URLQueryItem(name: "lat", value: "42.613852"),
            URLQueryItem(name: "lon", value: "-83.183901"),
            URLQueryItem(name: "appid", value: "417e9505238da90a0eb7a6a109c371b2")
        ]
        // string --> url
        let url = urlComponent?.url
        
        // url --> request
        var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        // update url method
        request.httpMethod = "GET"
        
        // create URL session
        let session = URLSession.shared
        let (data, response) = try await session.data(for: request)
        print(data)
        
        // check if response is 200 or throw an error and exit
        guard (response as? HTTPURLResponse)?.statusCode == 200 else{
            // throw an error
            throw apiError.responseCodeError
        }
        
        // start to decode data
        do {
            let jsondecoder = JSONDecoder()
            let decodedData = try jsondecoder.decode(weatherDataModel.self, from: data)
            print(decodedData)
            return decodedData
        } catch  {
            throw apiError.cannotDecodeJSON
        }
        
        
    }
    
}


