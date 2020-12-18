//
//  statusManager.swift
//  StatusCovid19
//
//  Created by Mac1 on 16/12/20.
//

import Foundation
protocol StatusCovidDelegate {
    func updateStatus(status: statusModel)
    
    func findError(whichError: Error)
}
struct statusManager {
    var delegado: StatusCovidDelegate?
    let statusUrl = "https://corona.lmao.ninja/v3/covid-19/countries"
    func getData(namePais: String){
        let urlString="\(statusUrl)/\(namePais)"
        requestStatus(urlString: urlString)
    }
    func requestStatus(urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){(data, respuesta, error)in
                if error != nil{
                    delegado?.findError(whichError: error!)
                    return
                }
                if let secureData = data{
                    if let status = self.parseJSON(Decodifier: secureData){
                        delegado?.updateStatus(status: status)
                    }
                }
                
            }
            task.resume()
        }
    }
    func parseJSON(Decodifier: Data) -> statusModel?{
        let decoder = JSONDecoder()
        do{
            let decodifiedData = try decoder.decode(decodifier.self, from: Decodifier)
            let pais = decodifiedData.country
            let casos = decodifiedData.cases
            let muertes = decodifiedData.deaths
            let recuperados = decodifiedData.recovered
            let bandera = decodifiedData.countryInfo.flag
            let objStatus = statusModel(pais: pais, casos: casos, muertes: muertes, recuperados: recuperados, bandera: bandera)
            return objStatus
        }catch {
            delegado?.findError(whichError: error)
            return nil
        }
    }
}
