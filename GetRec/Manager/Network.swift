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
    @Published var login_success: Bool = false
    @Published var login_failure: Bool = false
    @Published var signup_success: Bool = false
    @Published var username: String = ""
    
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
    
    func logout() {
        guard let url = URL(string: "https://get-rec-v2.herokuapp.com/logout") else { fatalError("Missing URL") }

        let urlRequest = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 { return }
        }
        dataTask.resume()
    }
    
    func login(username: String, password: String) {
        self.login_success = false
        self.login_failure = false
        self.username = ""
        guard let url = URL(string: "https://get-rec-v2.herokuapp.com/login") else { fatalError("Missing URL") }

        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("authToken", forHTTPHeaderField: "Authorization")
        
        let body = ["username": "\(username)", "password": "\(password)"]
        let bodyData = try? JSONSerialization.data(
            withJSONObject: body,
            options: []
        )
        
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = bodyData

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }
            print(body)
            print(response.statusCode)
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        //let decodedApps = try JSONDecoder().decode(AppAlias.self, from: data)
                        //for (value) in decodedApps {
                            //self.apps.append(value.value)
                        print("success")
                        self.login_success = true
                        self.username = username
                        //}
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    do {
                        //let decodedApps = try JSONDecoder().decode(AppAlias.self, from: data)
                        //for (value) in decodedApps {
                            //self.apps.append(value.value)
                        print("failure")
                        self.login_failure = true
                        //}
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    func signup(username: String, password: String, password_confirm: String) {
        self.signup_success = false
        self.username = ""
        guard let url = URL(string: "https://get-rec-v2.herokuapp.com/signup") else { fatalError("Missing URL") }

        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("authToken", forHTTPHeaderField: "Authorization")
        
        let body = ["username": "\(username)", "password": "\(password)", "password-confirm": "\(password_confirm)"]
        let bodyData = try? JSONSerialization.data(
            withJSONObject: body,
            options: []
        )
        
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = bodyData

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }
            print(body)
            print(response.statusCode)
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        //let decodedApps = try JSONDecoder().decode(AppAlias.self, from: data)
                        //for (value) in decodedApps {
                            //self.apps.append(value.value)
                        self.signup_success = true
                        self.username = username
                        //}
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    func getRec(query: String, item_type: String) {
        self.signup_success = false
        guard let url = URL(string: "https://get-rec-v2.herokuapp.com/get-rec") else { fatalError("Missing URL") }

        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("authToken", forHTTPHeaderField: "Authorization")
        
        let body = ["query": "\(query)", "item_type": "\(item_type)"]
        let bodyData = try? JSONSerialization.data(
            withJSONObject: body,
            options: []
        )
        
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = bodyData

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }
            print(body)
            print(response.statusCode)
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        //let decodedApps = try JSONDecoder().decode(AppAlias.self, from: data)
                        //for (value) in decodedApps {
                            //self.apps.append(value.value)
                        self.signup_success = true
                        //}
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
}
