//
//  ApiHandler.swift
//  CountryApp
//
//  Created by Akash Katoch on 15/01/22.
//
//


import Foundation
import Alamofire

final class ApiHandler{
    
    static let shared = ApiHandler()
    private init(){}
    
    //let urlString = "https://newsapi.org/v2/everything?q=example&apiKey=c41dd5fe48d4440fbffb86964f8fd758"
    let urlString = "https://demo2039952.mockable.io/"

    
    func getApiCalling(completion : @escaping ([CountryModel]) -> ()){
        
        guard let baseUrl = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: baseUrl) { data, response, error in
            guard let data = data else { return }
            
            do {
                let countryData = try JSONDecoder().decode([CountryModel].self, from: data)
                completion(countryData)
            } catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    
    func postApiCalling(){
        guard let urlString = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        var request = URLRequest(url: urlString)
        request.httpMethod = "POST"
        let parameter = PostModel(title: "Xman", body: "Marvel", id: 101)
        request.httpBody = try? JSONEncoder().encode(parameter)
        
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            do {
                let sample = try JSONDecoder().decode(PostModel.self, from: data)
                print(sample)
            } catch {
                print(error)
            }
        }.resume()
        
        
    }
    
    struct PostModel: Codable{
        var title: String
        var body: String
        var id: Int
    }
    
//    func getDataUsingAlamofire(completion : @escaping ([Article]) -> ()){
//        AF.request(urlString).response { response in
//            switch response.result{
//            case .success(let data):
//                guard let data = data else { return }
//                do {
//                    let newsData = try JSONDecoder().decode(NewsModel.self , from: data)
//                    completion(newsData.articles)
//                } catch {
//                    print(error)
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
    
    func getDataUsingAlamofire(completion : @escaping ([CountryModel]) -> ()){
        AF.request(urlString).response { response in
            switch response.result{
            case .success(let data):
                guard let data = data else { return }
                do {
                    let countryData = try JSONDecoder().decode([CountryModel].self , from: data)
                    completion(countryData)
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func postDataUsingAlamofire(){
        let parameter = PostModel(title: "Akash", body: "Katoch", id: 1102)
        AF.request("https://jsonplaceholder.typicode.com/posts", method: .post, parameters: parameter).response { response in
            switch response.result{
            case .success(let data):
                guard let data = data else { return }
                do {
                    let temp = try JSONDecoder().decode(PostModel.self, from: data)
                    print(temp)
                } catch{
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
