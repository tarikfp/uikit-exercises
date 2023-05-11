//
//  Petition.swift
//  PetitionsJsonTabbar
//
//  Created by Tarık Fatih PINARCI on 11.05.2023.
//

import Foundation

struct Petition: Codable {
  let title: String
  let body: String?
  let signatureCount: Int
}
