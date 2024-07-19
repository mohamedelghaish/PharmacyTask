# Pharmacy Return Request Mobile Application

This mobile application allows users to manage return requests for their pharmacy, including logging in, creating return requests, adding items, and managing those items. The app uses provided APIs to interact with a backend service.

## Features

Login Screen: Users can log in using their credentials.
Return Requests Screen: View all return requests, including details such as ID, creation date, number of items, status, and service type. Option to create new return requests and view items associated with each request.
Create Return Request Screen: Allows users to create a new return request by selecting a service type and wholesaler.
Add Item Screen: Users can add new items to a return request, including details such as NDC, description, manufacturer, quantities, expiration date, and lot number.
Items Screen: Displays all items in a return request with functionality to update or delete items.


## Technology Stack

Platform: iOS 
Networking: Alamofire (for iOS) 
UI Framework: UIKit (for iOS) 
Design Patterns: MVVM


## Design Decisions

MVVM Pattern: The application follows the MVVM pattern to separate concerns and ensure a clean architecture.
Alamofire for Networking: Used for making network requests due to its simplicity and powerful features.
Contributing

## Prerequisites


Xcode 14+ for iOS development
Swift 5.0+ or equivalent
CocoaPods or Swift Package Manager for dependency management
