//
//  URL+Parameters.swift
//  Astra
//
//  Created by Андрей Чернышев on 07.10.2022.
//

import Foundation

extension URL {
    init?(path: String, parameters: [(String, String)]) {
        let items = parameters.map { URLQueryItem(name: $0, value: $1) }
        
        guard var components = URLComponents(string: path) else {
            return nil
        }

        components.queryItems = items

        guard let url = components.url else {
            return nil
        }
        
        self = url
    }
}
