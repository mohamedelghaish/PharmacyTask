//
//  CreateReturnRequestResponse.swift
//  PharmacyTask
//
//  Created by Mohamed Kotb Saied Kotb on 18/07/2024.
//

import Foundation

struct User: Codable {
    let id: Int
    let createdAt: String
    let updatedAt: String?
    let username: String
    let password: String
    let email: String
    let role: String
    let phoneNumber: String?
    let activated: Bool
}


struct Pharmacy: Codable {
    let id: Int
    let createdAt: String
    let updatedAt: String
    let user: User
    let enabled: Bool
    let licenseState: String
    let licenseStateCode: String
    let npi: String
    let doingBusinessAs: String
    let legalBusinessName: String
    let companyType: String
    let reimbursementType: String
    let directDepositInfo: String?
    let dea: String
}


struct CreateReturnRequestResponse: Codable {
    let id: Int
    let createdAt: String
    let updatedAt: String
    let pharmacy: Pharmacy
    let dateDispatched: String?
    let dateFulfilled: String?
    let disbursements: String?
    let serviceFee: String?
    let returnRequestStatus: String
    let returnRequestStatusLabel: String
    let serviceType: String
    let preferredDate: String?
}

