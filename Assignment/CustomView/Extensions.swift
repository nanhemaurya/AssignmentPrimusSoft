//
//  Extensions.swift
//  Assignment
//
//  Created by SMN Boy on 28/01/22.
//

import Foundation
import UIKit

extension UICollectionView {
    private func reuseIndentifier<T>(for type: T.Type) -> String {
        return String(describing: type)
    }
    
    // if your cell is designed in Interface builder
    public func registerWithNib<T: UICollectionViewCell>(cell: T.Type) {
        register(T.self, forCellWithReuseIdentifier: reuseIndentifier(for: cell))
        register(UINib.init(nibName: reuseIndentifier(for: cell), bundle: nil), forCellWithReuseIdentifier: reuseIndentifier(for: cell))
    }
}
