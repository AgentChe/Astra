//
//  NetworkError.swift
//  Astra
//
//  Created by Андрей Чернышев on 07.10.2022.
//

struct NetworkError: Error {
    enum Code {
        case serverNotAvailable
    }

    let code: Code
    let underlyingError: Error?

    init(_ code: Code, underlyingError: Error? = nil) {
        self.code = code
        self.underlyingError = underlyingError
    }
}
