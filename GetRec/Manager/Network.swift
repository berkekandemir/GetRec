//
//  Network.swift
//  GetRec
//
//  Created by Berke Can Kandemir on 5/26/22.
//

import Foundation
import SwiftUI

class Network: ObservableObject {
    @Published var apps: [App] = []
    
    func getApps() {
        self.apps = []
        guard let url = URL(string: "https://get-rec-v2.herokuapp.com/apps") else { fatalError("Missing URL") }

        let urlRequest = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedApps = try JSONDecoder().decode(AppAlias.self, from: data)
                        for (value) in decodedApps {
                            self.apps.append(value.value)
                            //print("\(value.value)")
                        }
                        //self.apps = decodedApps
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
}
