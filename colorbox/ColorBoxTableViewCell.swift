//
//  ColorBoxTableViewCell.swift
//  colorbox
//
//  Created by Nick O'Neill on 3/2/16.
//  Copyright © 2016 That Thing in Swift. All rights reserved.
//

import UIKit

class ColorBoxTableViewCell: UITableViewCell {
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!

    func configure(color: ColorBox) {
        titleLabel.text = color.name
        descLabel.text = color.desc

        colorView.backgroundColor = color.color
    }
}
