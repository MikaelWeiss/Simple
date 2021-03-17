//
//  UIImage+Extensions.swift
//  Simple
//
//  Created by Mikael Weiss on 2/15/21.
//

import UIKit

extension UIImage {
    convenience init?(optionalData: Data?) {
        guard let data = optionalData else { return nil }
        self.init(data: data)
    }
}
