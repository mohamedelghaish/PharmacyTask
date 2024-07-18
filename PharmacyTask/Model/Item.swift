//
//  Item.swift
//  PharmacyTask
//
//  Created by Mohamed Kotb Saied Kotb on 18/07/2024.
//

import Foundation
struct Item: Codable {
    let id: Int
    let createdAt: String
    let updatedAt: String
    let ndc: String
    var description: String
    let manufacturer: String
    let packageSize: String
    let requestType: String
    let name: String
    let strength: String
    let dosage: String
    let fullQuantity: Double
    let partialQuantity: Double
    let expirationDate: String
    let status: String
    let lotNumber: String
    let expectedReturnValue: Double
    let actualReturnValue: Double
    let gtin14: String?
    let serialNumber: String?
    let controlledSubstanceCode: String?
    let adminComment: String?
}
