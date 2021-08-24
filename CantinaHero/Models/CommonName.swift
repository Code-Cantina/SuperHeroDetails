//
//  CommonName.swift
//  CantinaHero
//
//  Created by Danny Copeland on 8/21/21.
//

import Foundation

// MARK: - CommonSuperHero
struct CommonSearch: Codable {
    let common: [CommonName]
}

// MARK: - Common
struct CommonName: Codable {
    let name: String
    let image_path: String
}
