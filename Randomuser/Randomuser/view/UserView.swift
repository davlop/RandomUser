//
//  UserView.swift
//  Randomuser
//
//  Created by David Lopez on 19/9/22.
//

import Foundation
import UIKit

final class UserView: UIView {
    
    // MARK: Tags
    private static let holderViewTag = 1000
    private static let avatarTag = 1001
    private static let nameTag = 1002
    
    // MARK: UI elements
    private let holderView: UIView = UIView()
    private let avatarImage: UIImageView = UIImageView()
    private let nameLabel: UILabel = UILabel()
    
    // MARK: Set-up
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        updateFrames()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        if let holderView = viewWithTag(UserView.holderViewTag) {
            holderView.removeFromSuperview()
        } else {
            holderView.tag = UserView.holderViewTag
            addSubview(holderView)
        }
        
        if let avatarView = viewWithTag(UserView.avatarTag) {
            avatarView.removeFromSuperview()
        } else {
            avatarImage.tag = UserView.avatarTag
            avatarImage.contentMode = .scaleAspectFit
            holderView.addSubview(avatarImage)
        }
        
        if let nameLabelView = viewWithTag(UserView.nameTag) {
            nameLabelView.removeFromSuperview()
        } else {
            nameLabel.tag = UserView.nameTag
            nameLabel.textAlignment = .center
            nameLabel.numberOfLines = 1
            nameLabel.font = UIFont.systemFont(ofSize: TextSizes.LargeTextFont, weight: UIFont.Weight.regular)
            holderView.addSubview(nameLabel)
        }
    }
    
    private func updateFrames() {
        holderView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        avatarImage.frame = CGRect(x: 0, y: 0, width: holderView.frame.width, height: holderView.frame.height * 0.75)
        nameLabel.frame = CGRect(x: 0, y: avatarImage.frame.origin.y + avatarImage.frame.size.height + 5, width: holderView.frame.width, height: holderView.frame.height * 0.25 - 5)
    }
    
    // MARK: Public
    func setUserName(_ name: String) {
        nameLabel.text = name
    }
    
    func resetAvatarImage() {
        avatarImage.image = nil
    }
    
    func setAvatarImage(_ imageUrl: URL, placeHolderImageName: String, errorImageName: String) {
        avatarImage.load(url: imageUrl, placeholder: UIImage(named: placeHolderImageName), errorImage: UIImage(named: errorImageName))
    }
}

