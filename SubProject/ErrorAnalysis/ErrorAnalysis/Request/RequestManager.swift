//
//  RequestManager.swift
//  ErrorAnalysis
//
//  Created by sharui on 2022/2/6.
//

import Cocoa
import Combine


class RequestManager: NSObject {
    var baseUrl: String {
        var base = "http://10.71.6.210:4000"
        ServerData.shared.updateFromDB()
        if let customString = ServerData.shared.servers.filter({$0.selected}).first?.ip {
            base = customString
        }
        return base
    }
    
    func search(str: String) -> AnyPublisher<String, Never> {
        guard var urlComponents = URLComponents(string: "https://api.github.com/search/repositories") else {
          preconditionFailure("链接无效")
        }
        urlComponents.queryItems = [URLQueryItem(name: "q", value: str)]
         
        guard let url = urlComponents.url else {
          preconditionFailure("链接无效")
        }
        let sch = DispatchQueue(label: "API", qos: .default, attributes: .concurrent)
         
        return URLSession.shared
          .dataTaskPublisher(for: url)
          .receive(on: sch)
          .tryMap({ element -> Data in
            print(String(decoding: element.data, as: UTF8.self))
            return element.data
          })
          .decode(type: String.self, decoder: JSONDecoder())
          .catch { _ in
            Empty().eraseToAnyPublisher()
          }
          .eraseToAnyPublisher()
      }
    
    
    func request(requestModel: ParsingRequestModel, orginJsonString: String, complete: @escaping (ParsingRequestModel, ParsingResultModel?)->()) {
        
        ParsingViewModel.shared.parsing = true
        let dict = requestModel.transformToDict()
        print(dict)
        var  jsonData = NSData()
        do {
            jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) as NSData
            
        } catch {
            print(error.localizedDescription)
        }
        
        // 构建URL
        let url:URL = URL(string: baseUrl + "/ios")!
        // session
        let session = URLSession.shared
        // request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // 设置Content-Length，非必须
        request.setValue("\(jsonData.length)", forHTTPHeaderField: "Content-Length")
        // 设置 Content-Type 为 json 类型
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // POST    请求将 数据 放置到 请求体中
        
        request.httpBody = jsonData as Data
        // 发送请求
        let task = session.dataTask(with: request) {(
            data, response, error) in
            
            DispatchQueue.main.async {
                ParsingViewModel.shared.parsing = false
            }
            guard let data = data, let _:URLResponse = response, error == nil else {
                complete(requestModel,nil)
                return
            }
            
            // 返回值 utf8 转码
            let dataString =  String(data: data, encoding: .utf8)?.removingPercentEncoding ?? ""
            let resultModel = ParsingResultModel.creatModel(orginJsonString: orginJsonString, orginParsingJsonString: dataString)
            complete(requestModel,resultModel)
        }
        task.resume()
    }
    
    
    func test_request(complete: @escaping (Bool)->()) {
        search(str: "123").sink { test in
            print(test)
        }
        ParsingViewModel.shared.parsing = true
        // 构建URL
        let url:URL = URL(string: baseUrl + "/iostest")!
        // session
        let session = URLSession.shared
        // request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        // 设置 Content-Type 为 json 类型
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // 发送请求
        let task = session.dataTask(with: request) {(
            data, response, error) in
            DispatchQueue.main.async {
                ParsingViewModel.shared.parsing = false
                complete(error != nil)
            }
        }
        task.resume()
       
    }
}
