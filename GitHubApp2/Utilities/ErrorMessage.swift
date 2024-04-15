//
//  ErrorMessage.swift
//  GitHubApp2
//
//  Created by Amrah on 23.03.24.
//

import Foundation


//This is
enum GFError: String, Error{
    case invalidUsername = "This user name created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    
}
