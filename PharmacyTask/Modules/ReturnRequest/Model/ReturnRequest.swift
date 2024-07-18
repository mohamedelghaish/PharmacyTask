//
//  ReturnRequest.swift
//  PharmacyTask
//
//  Created by Mohamed Kotb Saied Kotb on 18/07/2024.
//

import Foundation

struct ReturnRequest: Codable {
    let id: Int
    let createdAt: TimeInterval
    let returnRequestStatus: String
    let returnRequestStatusLabel: String
    let serviceType: String
}

struct ReturnRequestContent: Codable {
    let returnRequest: ReturnRequest
    let numberOfItems: Int
}

struct ReturnRequestResponse: Codable {
    let content: [ReturnRequestContent]
}

