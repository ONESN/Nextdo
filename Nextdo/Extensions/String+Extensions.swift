//
//  String+Extensions.swift
//  Nextdo
//
//  Created by 君の名は on 9/19/24.
//

import Foundation

extension String {
    
    var isEmptyOrWhitespace: Bool {
        trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
