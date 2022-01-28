//
//  CustomButton.swift
//  Assignment
//
//  Created by SMN Boy on 28/01/22.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    func onTap(action: (() -> Void)?) { setOnTap(action: action) }
    
    private func setOnTap(action: (() -> Void)?) {
        let gesture = customTapGesture(target: self, action: #selector(self.onTap(sender:)))
        gesture.action = action
        self.addGestureRecognizer(gesture)
    }
    
    @objc private func onTap(sender: customTapGesture) {
        sender.action?()
    }
    
}

