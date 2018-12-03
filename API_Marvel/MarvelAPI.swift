//
//  MarvelAPI.swift
//  API_Marvel
//
//  Created by Josimar  Fiuza Melo on 02/12/18.
//  Copyright © 2018 Josimar Fiuza Melo. All rights reserved.
//

import Foundation
import SwiftHash
import Alamofire

class MarvelAPI {
    
    static let basePath = "https://gateway.marvel.com/v1/public/characters?"
    static let privateKey = "5e9a46088c2eb456f3a9c9cc50d394ebeb08d5ce"
    static let publicKey = "2d38ac7c9946da02d968f4dc43efd3a3"
    static let limit = 50
    
    
    class func getCredentials() -> String {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(ts+privateKey+publicKey).lowercased()
        
        return "ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
    }
    
    
    class func loadHeros(name:String?, page: Int = 0, onComplete: @escaping (MarvelInfo?)-> Void ) {
        
        let offSet = page * limit
        let startsWish: String
        
        if let name = name, !name.isEmpty{
            startsWish = "nameStartsWith=\(name.replacingOccurrences(of: " ", with: ""))&"
        }else{
            startsWish = ""
        }
        
        let url = basePath + "offset=\(offSet)&limit=\(limit)&" + startsWish + getCredentials()
        print(url)
        
        
        Alamofire.request(url).responseJSON { (response) in
            guard let data = response.data else{
                onComplete(nil)
                return
            }
            
            do{
                let marvelInfo = try? JSONDecoder().decode(MarvelInfo.self, from: data)
                onComplete(marvelInfo)
            }catch{
                print(error.localizedDescription)
                onComplete(nil)
            }
        }
    }
    
}
