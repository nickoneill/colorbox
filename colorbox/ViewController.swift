//
//  ViewController.swift
//  colorbox
//
//  Created by Nick O'Neill on 3/2/16.
//  Copyright © 2016 That Thing in Swift. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    var colors: [ColorBox] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 125
        tableView.rowHeight = UITableViewAutomaticDimension

        ColorClient.sharedClient.getColors {[weak self](colors) in
            self?.colors = colors

            dispatch_async(dispatch_get_main_queue(), { 
                self?.tableView.reloadData()

                if colors.count > 0 {
                    self?.selected(colors.first!.color)
                }
            })
        }
    }

    func selected(color: UIColor) {
        headerView.backgroundColor = color
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("colorCell", forIndexPath: indexPath) as! ColorBoxTableViewCell

        let color = colors[indexPath.row]
        cell.configure(color)

        return cell
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 160
    }

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let color = colors[indexPath.row]

        selected(color.color)
    }

    // I've removed this method of cell heights in favor of automatic cell heights!
    // see viewDidLoad for the other settings needed for this to work correctly
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        let topSpace: CGFloat = 16
//        let topLabelHeight: CGFloat = 25
//        let topLabelSpacing: CGFloat = 7
//
//        let color = colors[indexPath.row]
//        let font = UIFont(name: "Helvetica", size: 17.0)!
//        let textRect = (color.desc as NSString).boundingRectWithSize(CGSize(width: 240, height: 9999), options: [.UsesLineFragmentOrigin], attributes: [NSFontAttributeName: font], context: NSStringDrawingContext())
//
//        let textHeight: CGFloat = textRect.height
//
//        return topSpace + topLabelHeight + topLabelSpacing + textHeight + topSpace
//    }
}

