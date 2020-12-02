//
//  TableView+NibLoadable.swift
//  Bewist
//
//  Created by Ghost on 16.04.2020.
//  Copyright © 2020 Hadevs. All rights reserved.
//

import UIKit

extension UITableView {
  func register(_ nibLoadableType: NibLoadable.Type) {
    register(nibLoadableType.nib, forCellReuseIdentifier: nibLoadableType.name)
  }

  func getCell<T: NibLoadable & UITableViewCell>(by indexPath: IndexPath) -> T {
    return dequeueReusableCell(withIdentifier: T.name, for: indexPath) as! T
  }
}

