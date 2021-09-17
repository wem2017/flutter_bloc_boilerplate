//
//  SmallWidget.swift
//  Runner
//
//  Created by Hanbiro on 30/03/2021.
//

import Foundation

struct SmallWidgetModel: Decodable {
    let detail: String
    let amount: Float
    let image: URL
    let date: String
    let auGTS: Float
    let euVAT: Float
    let usRWT: Float
    let usBWT: Float
}

