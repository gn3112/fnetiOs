//
//  APIRequest.swift
//  fnet
//
//  Created by Georges on 09/05/2020.
//  Copyright © 2020 Nomicos. All rights reserved.
//

import Foundation
import UIKit

struct APIRequest {
    let ressourceURL: URL
    
    init(endpoint: String){
        let ressourceString = "http://172.20.10.2:5000/\(endpoint)"
        guard let ressourceURL = URL(string: ressourceString) else {fatalError()}
        
        self.ressourceURL = ressourceURL
    }
    
    func sendImage(image: UIImage, completionHandler: @escaping (String?, URLSession.ResponseDisposition) -> Void) -> Void {
        var request = URLRequest(url: ressourceURL)
        request.httpMethod = "POST"
        request.addValue("image/jpeg", forHTTPHeaderField: "Content-Type")
        request.httpBody = image.jpegData(compressionQuality: 1)
    
        let dataTask = URLSession.shared.dataTask(with: request) {data, response, _ in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let returnData = data else {completionHandler(nil,.cancel)
                return
            }
            
            let str = String(decoding: returnData, as: UTF8.self)
            completionHandler(str, .allow)
        }
        dataTask.resume()
        

    }
}

