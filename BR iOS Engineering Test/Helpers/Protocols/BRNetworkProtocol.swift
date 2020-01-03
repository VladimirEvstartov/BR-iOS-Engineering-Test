//
//  BRNetworkProtocol.swift
//  BR iOS Engineering Test
//
//  Created by Vladimir on 29.12.2019.
//  Copyright © 2019 Vladimir. All rights reserved.
//

import UIKit

protocol BRNetworkProtocol {
    func loadJsonData<T: Decodable>(url: URL, returningClass: T.Type, completion: ((T?, Error?) -> Void)?)
    func getImage(urlString: String, completion: ((UIImage?) -> Void)?)
}

extension BRNetworkProtocol {
    func loadJsonData<T: Decodable>(url: URL, returningClass: T.Type, completion: ((T?, Error?) -> Void)?) {
        
        DispatchQueue.global(qos: .userInitiated).sync {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { data, response, error in
                guard  error == nil, let data = data else {
                    DispatchQueue.main.async {
                        completion?(nil, error)
                    }
                    return
                }
                guard let response = response, let mime = response.mimeType, mime == "application/json" else {
                    DispatchQueue.main.async {
                        completion?(nil, BRError.wrongMIMEType)
                    }
                    return
                }
                do {
                    let result = try JSONDecoder().decode(returningClass, from: data)
                    DispatchQueue.main.async {
                        completion?(result, nil)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion?(nil, error)
                    }
                }
            }
            task.resume()
        }
    }
    
    func getImage(urlString: String, completion: ((UIImage?) -> Void)?) {
        guard let url = URL(string: urlString) else { return}
        var image: UIImage?
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = try? Data(contentsOf: url) {
                 image = UIImage(data: data)
            }
            completion?(image)
        }
    }
}
