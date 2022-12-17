//
//  DataModel.swift
//  OpenWeatherAPI
//
//  Created by Jianan Li on 12/9/22.
//

import Foundation


class weatherDataModel : Decodable{
    var coord : Coord = Coord()
    var weather : [Weather] = [Weather]()
    var main : Main = Main()
    
}

class Coord : Decodable{
    var lon : Double = 0.0
    var lat : Double = 0.0
}

class Weather : Decodable{
    //var id : Int = 0
    var main : String = ""
    var description : String = ""
    var icon : String = ""
}

class Main : Decodable{
    var temp : Double = 0.0
    var feels_like : Double = 0.0
    var temp_min : Double = 0.0
    var temp_max : Double = 0.0
}

