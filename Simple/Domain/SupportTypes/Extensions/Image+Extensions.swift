//
//  Image+Extensions.swift
//  Simple
//
//  Created by Mikael Weiss on 2/15/21.
//

import SwiftUI

extension Image {
    init?(data: Data?) {
        guard let data = data else { return nil }
        guard let image = UIImage(data: data) else { return nil }
        self = Image(uiImage: image)
    }
}
