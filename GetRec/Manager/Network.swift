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
    @Published var books: [Book] = []
    @Published var movies: [Movie] = []
    @Published var games: [Game] = []
    @Published var suggestions: [String] = []
    //@Published var login_success: Bool = false
    @AppStorage("login_success") var login_success: Bool = false
    @AppStorage("login_failure") var login_failure: Bool = false
    @AppStorage("signup_success") var signup_success: Bool = false
    @AppStorage("signup_failure") var signup_failure: Bool = false
//    @Published var login_success: Bool = false
//    @Published var login_failure: Bool = false
//    @Published var signup_success: Bool = false
    @AppStorage("username") var username: String = ""
    @AppStorage("email") var email: String = ""
    
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
        self.login_success = false
        self.login_failure = false
        self.signup_success = false
        self.signup_failure = false
        self.username = ""
        self.email = ""
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
    
    func login(username: String, password: String) async throws {
//        self.login_success = false
//        self.login_failure = false
//        self.username = ""
        guard let url = URL(string: "https://get-rec-v2.herokuapp.com/login") else { fatalError("Missing URL") }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let body = ["username": "\(username)", "password": "\(password)"]
        let bodyData = try? JSONSerialization.data(
            withJSONObject: body,
            options: []
        )
        
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = bodyData

//        let dataTask = try await URLSession.shared.data(from: urlRequest) { (data, response, error) in
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
//            if let error = error {
//                print("Request error: ", error)
//                return
//            }
        
//        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
//            self.login_failure = true
//            fatalError("Error while fetching data")
//        }
//        let user = try JSONDecoder().decode(User.self, from: data)
//        print("success")
//        self.login_success = true
//        self.username = user.username
//        self.email = user.email
        
        if (response as? HTTPURLResponse)?.statusCode == 200 {
            let user = try JSONDecoder().decode(User.self, from: data)
            print("success")
            self.login_success = true
            self.username = user.username
            self.email = user.email
        } else {
            //fatalError("Error while fetching data")
            self.login_failure = true
        }
        
//        let decodedFood = try JSONDecoder().decode(Food.self, from: data)
//            guard let response = response as? HTTPURLResponse else { return }
//            if let JSONString = String(data: bodyData!, encoding: String.Encoding.utf8) {
//               print(JSONString)
//            }
//            if response.statusCode == 200 {
//                guard let data = data else { return }
//                DispatchQueue.main.async {
//                    do {
//                        print("success")
//                        self.login_success = true
//                        self.username = username
//                    } catch let error {
//                        print("Error decoding: ", error)
//                    }
//                }
//            } else {
//                DispatchQueue.main.async {
//                    do {
//                        self.login_failure = true                    } catch let error {
//                        print("Error decoding: ", error)
//                    }
//                }
//            }
//        }
//        dataTask.resume()
    }
    
    func signup(username: String, password: String, password_confirm: String, email: String) async throws {
//        self.signup_success = false
//        self.username = ""
//        self.email = ""
        guard let url = URL(string: "https://get-rec-v2.herokuapp.com/signup") else { fatalError("Missing URL") }

        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let body = ["username": "\(username)", "password": "\(password)", "password-confirm": "\(password_confirm)", "email": "\(email)"]
        let bodyData = try? JSONSerialization.data(
            withJSONObject: body,
            options: []
        )
        
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = bodyData
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        //guard (response as? HTTPURLResponse)?.statusCode == 200 else {
        if (response as? HTTPURLResponse)?.statusCode == 200 {
            print("success")
            self.signup_success = true
            self.username = username
            self.email = email
        } else {
            //fatalError("Error while fetching data")
            self.signup_failure = true
        }
//        print("success")
//        self.signup_success = true
//        self.username = username

//        let dataTask = await URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
//            if let error = error {
//                print("Request error: ", error)
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse else { return }
//            print(body)
//            print(response.statusCode)
//            if response.statusCode == 200 {
//                guard let data = data else { return }
//                DispatchQueue.main.async {
//                    do {
//                        self.signup_success = true
//                        self.username = username
//                    } catch let error {
//                        print("Error decoding: ", error)
//                    }
//                }
//            }
//        }
//        dataTask.resume()
    }
    
    func getRec(query: String, type: String) async throws {
        guard let url = URL(string: "https://get-rec-v2.herokuapp.com/get-rec") else { fatalError("Missing URL") }

        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let body = ["query": "\(query)", "type": "\(type)"]
        let bodyData = try? JSONSerialization.data(
            withJSONObject: body,
            options: []
        )
        
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = bodyData
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        if (response as? HTTPURLResponse)?.statusCode == 200 {
            if (type == "book") {
                let book_list = try JSONDecoder().decode(Books.self, from: data)
                for (value) in book_list {
                    self.books.append(value.value)
                }
            } else if (type == "movie") {
                let movie_list = try JSONDecoder().decode(Movies.self, from: data)
                for (value) in movie_list {
                    self.movies.append(value.value)
                }
            } else if (type == "game") {
                let game_list = try JSONDecoder().decode(Games.self, from: data)
                for (value) in game_list {
                    self.games.append(value.value)
                }
            }
        } else {
            //fatalError("Error while fetching data")
        }

//        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
//            if let error = error {
//                print("Request error: ", error)
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse else { return }
//            print(body)
//            print(response.statusCode)
//            if response.statusCode == 200 {
//                guard let data = data else { return }
//                DispatchQueue.main.async {
//                    do {
//                        self.signup_success = true
//                    } catch let error {
//                        print("Error decoding: ", error)
//                    }
//                }
//            }
//        }
//        dataTask.resume()
    }
    
    func autoFill(query: String, type: String) throws {
        guard let url = URL(string: "https://get-rec-v2.herokuapp.com/items-starting-with") else { fatalError("Missing URL") }

        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let body = ["query": "\(query)", "type": "\(type)"]
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
        if response.statusCode == 200 {
            guard let data = data else { return }
            DispatchQueue.main.async {
                do {
                    self.suggestions = try JSONDecoder().decode([String].self, from: data)
                } catch let error {
                    print("Error decoding: ", error)
                }
            }
        }
    }
    dataTask.resume()
//        let (data, response) = try await URLSession.shared.data(for: urlRequest)
//
//        if (response as? HTTPURLResponse)?.statusCode == 200 {
//            print("success")
//            self.suggestions = try JSONDecoder().decode([String].self, from: data)
//            print(self.suggestions)
//        } else {
//            fatalError("Error while fetching data")
//        }
    }
}
