//
//  SelfSizedTableView.swift
//  Gamata
//
//  Created by Aruna Udayanga on 9/3/19.
//  Copyright © 2019 Aruna Udayanga. All rights reserved.
//

import Foundation
import UIKit

class SelfSizedTableView: UITableView {
    var maxHeight: CGFloat = UIScreen.main.bounds.size.height
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }
    
    override var intrinsicContentSize: CGSize {
        setNeedsLayout()
        layoutIfNeeded()
        let height = min(contentSize.height, maxHeight)
        return CGSize(width: contentSize.width, height: height)
    }
}

class AutomaticHeightTableView: UITableView {

  override var contentSize: CGSize {
    didSet {
      self.invalidateIntrinsicContentSize()
    }
  }

  override var intrinsicContentSize: CGSize {
    self.layoutIfNeeded()
    return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height + 20)
  }

}
