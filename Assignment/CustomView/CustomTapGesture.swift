//
//  CustomTapGesture.swift
//  Assignment
//
//  Created by SMN Boy on 28/01/22.
//

import Foundation
import UIKit

class customTapGesture: UITapGestureRecognizer {
    var action: (() -> Void)? = nil
}
