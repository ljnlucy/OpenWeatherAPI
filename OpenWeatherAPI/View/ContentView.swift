//
//  ContentView.swift
//  OpenWeatherAPI
//
//  Created by Jianan Li on 12/9/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var weather : WeatherViewModel = WeatherViewModel()
    @State private var weatherData : weatherDataModel?
    var body: some View {
        VStack {
            if let weatherData = weatherData{
                VStack{
                    // section 1
                    Text("Location:")
                    HStack{
                        Text("Lat: \(weatherData.coord.lat)")
                        Text("Lon: \(weatherData.coord.lon)")
                    }
                    
                    // section2
                    Text("Weather")
                    if weatherData.weather.count > 0{
                        VStack{
                            Text("Main: \(weatherData.weather[0].main)")
                            Text("Description: \(weatherData.weather[0].description)")
                        }
                    }
                    
                    
                    // section 3
                    Text("Main:")
                    VStack{
                        Text("temp(F): \((weatherData.main.temp - 273.15)*9/5+32)")
                        Text("feels like: \(weatherData.main.feels_like)")
                        Text("min: \(weatherData.main.temp_min)")
                        Text("max: \(weatherData.main.temp_max)")
                    }
                }
            }
            
            
            // section 4 button
            Button {
                Task {
                    do{
                        self.weatherData = try await weather.sendRequest2()
                    }
                    catch{
                        print("some error")
                    }
                }
            } label: {
                Text("Fresh")
            }

        }
        .padding()
    }
}


