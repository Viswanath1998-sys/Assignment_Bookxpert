//
//  ApiRepository.swift
//  Bookxpert_Assignment
//
//  Created by Viswanath M on 26/05/25.
//

import Foundation

class ApiRepository{
    static let shared = ApiRepository()

    func callObjectsApi(completion: @escaping([DeviceObjects]) -> Void){
        guard let url = URL(string: "https://api.restful-api.dev/objects") else { return }
        URLSession.shared.dataTask(with: url){ data, response, error in
            if let data = data{
                do{
                    let decodedDevices = try JSONDecoder().decode([DeviceObjects].self, from: data)
//                    DispatchQueue.main.async {
                        completion(decodedDevices)
//                    }
                }catch{
                    print("Decoding error:", error)
                    completion([])
                }
            } else if let error = error{
                print("ApiRepository error:", error)
                completion([])
            }
        }.resume()
    }
}
