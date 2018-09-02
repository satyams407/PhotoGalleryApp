//
//  AppError.swift
//  PhotoGalleryApp
//
//  Created by Satyam Sehgal on 02/09/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import Foundation

class AppError: Error {
    private var errorType: ErrorType
    private var originalMessage: String?
    var errorCode: String?

    internal enum ErrorType {
        case networkError
        case paramsError
        case invalidAPIkey
    }

    var message: String? {
        var errorString: String
        switch errorType {
        case .networkError:
            errorString = "Currently, Network is not available"
        default:
            errorString = "generic error"
        }
        return errorString
    }

    required init(with errorType: ErrorType, error: Error?, message: String? = nil, code: String? = nil) {
        self.errorType = errorType
        self.errorCode = code
        self.originalMessage = message
    }
}
