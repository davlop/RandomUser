//
//  UserCell.swift
//  Randomuser
//
//  Created by David Lopez on 19/9/22.
//

import Foundation
import UIKit

final class UserCell: UITableViewCell {
    // MARK: Constants
    static let reuseId: String = "UserCell"
    
    // MARK: Tags
    private let userViewTag: Int = 4000
    
    // MARK: Data
    private var numberOfCells: Int = 0
    
    // MARK: Set-up
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView(numberOfCells: Int, width: CGFloat, height: CGFloat) {
        self.numberOfCells = numberOfCells
        let margin = CGFloat(10)
        let cellWidth = (width - 30) / CGFloat(numberOfCells)
        for cellNumber in 0...numberOfCells - 1 {
            if viewWithTag(userViewTag + cellNumber) == nil {
                let userView = UserView(frame: CGRect(x: 30 + (cellWidth * CGFloat(cellNumber)), y: margin, width: cellWidth - 30, height: height - margin * 2))
                userView.tag = userViewTag + cellNumber
                self.addSubview(userView)
            }
        }
    }
    
    // MARK: Public setters
    func setUserNames(firstNames: [String], lastNames: [String]) {
        if firstNames.count != lastNames.count {
            return
        }
        for index in 0...firstNames.count {
            if let firstName = firstNames[safe: index], let lastName = lastNames[safe: index], let userView = self.viewWithTag(userViewTag + index) as? UserView {
                userView.setUserName("\(firstName) \(lastName)")
            }
        }
    }

    func setUserImages(imageUrls: [String]) {
        for index in 0...imageUrls.count {
            if let imageUrl = imageUrls[safe: index], let url = URL(string: imageUrl), let userView = self.viewWithTag(userViewTag + index) as? UserView {
                userView.setAvatarImage(url, placeHolderImageName: "placeholder", errorImageName: "placeholder")
            }
        }
    }
    
    override func prepareForReuse() {
        for cellNumber in 0...numberOfCells - 1 {
            if let userView = viewWithTag(userViewTag + cellNumber) as? UserView {
                userView.resetAvatarImage()
            }
        }
    }
}

