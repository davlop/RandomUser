//
//  UserDetailsView.swift
//  Randomuser
//
//  Created by David Lopez on 26/9/22.
//

import Foundation
import UIKit

final class UserDetailsView: UIView {
    
    // MARK: Tags
    private static let holderViewTag = 3000
    private static let avatarTag = 3001
    private static let nameTag = 3002
    private static let separatorTag = 3003
    private static let countryViewTag = 3004
    private static let emailViewTag = 3005
    private static let phoneViewTag = 3006
    private static let dobViewTag = 3007
    private static let genderViewTag = 3008
    private static let userNameViewTag = 3009
    private static let passwordViewTag = 3010
    
    // MARK: UI elements
    private let holderView: UIView = UIView()
    private let avatarImage: UIImageView = UIImageView()
    private let nameLabel: UILabel = UILabel()
    private let separatorView: UIView = UIView()
    private let countryView: ImageTextView = ImageTextView()
    private let emailView: ImageTextView = ImageTextView()
    private let phoneView: ImageTextView = ImageTextView()
    private let dobView: ImageTextView = ImageTextView()
    private let genderView: ImageTextView = ImageTextView()
    private let userNameView: ImageTextView = ImageTextView()
    private let passwordView: ImageTextView = ImageTextView()
    
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
        if let holderView = viewWithTag(UserDetailsView.holderViewTag) {
            holderView.removeFromSuperview()
        } else {
            holderView.tag = UserDetailsView.holderViewTag
            addSubview(holderView)
        }
        
        if let avatarView = viewWithTag(UserDetailsView.avatarTag) {
            avatarView.removeFromSuperview()
        } else {
            avatarImage.tag = UserDetailsView.avatarTag
            avatarImage.contentMode = .scaleAspectFit
            holderView.addSubview(avatarImage)
        }
        
        if let nameLabelView = viewWithTag(UserDetailsView.nameTag) {
            nameLabelView.removeFromSuperview()
        } else {
            nameLabel.tag = UserDetailsView.nameTag
            nameLabel.textAlignment = .center
            nameLabel.numberOfLines = 1
            nameLabel.font = UIFont.systemFont(ofSize: TextSizes.XLargeTextFont, weight: UIFont.Weight.bold)
            holderView.addSubview(nameLabel)
        }
        
        if let separatorView = viewWithTag(UserDetailsView.separatorTag) {
            separatorView.removeFromSuperview()
        } else {
            separatorView.tag = UserDetailsView.separatorTag
            separatorView.layer.borderWidth = 1.0
            separatorView.layer.borderColor = UIColor.gray.cgColor
            holderView.addSubview(separatorView)
        }
        
        if let countryView = viewWithTag(UserDetailsView.countryViewTag) {
            countryView.removeFromSuperview()
        } else {
            countryView.tag = UserDetailsView.countryViewTag
            holderView.addSubview(countryView)
        }
        
        if let emailView = viewWithTag(UserDetailsView.emailViewTag) {
            emailView.removeFromSuperview()
        } else {
            emailView.tag = UserDetailsView.emailViewTag
            holderView.addSubview(emailView)
        }
        
        if let phoneView = viewWithTag(UserDetailsView.phoneViewTag) {
            phoneView.removeFromSuperview()
        } else {
            phoneView.tag = UserDetailsView.phoneViewTag
            holderView.addSubview(phoneView)
        }
        
        if let dobView = viewWithTag(UserDetailsView.dobViewTag) {
            dobView.removeFromSuperview()
        } else {
            dobView.tag = UserDetailsView.dobViewTag
            holderView.addSubview(dobView)
        }
        
        if let genderView = viewWithTag(UserDetailsView.genderViewTag) {
            genderView.removeFromSuperview()
        } else {
            genderView.tag = UserDetailsView.genderViewTag
            holderView.addSubview(genderView)
        }
        
        if let userNameView = viewWithTag(UserDetailsView.userNameViewTag) {
            userNameView.removeFromSuperview()
        } else {
            userNameView.tag = UserDetailsView.userNameViewTag
            holderView.addSubview(userNameView)
        }
        
        if let passwordView = viewWithTag(UserDetailsView.passwordViewTag) {
            passwordView.removeFromSuperview()
        } else {
            passwordView.tag = UserDetailsView.passwordViewTag
            holderView.addSubview(passwordView)
        }
    }
    
    private func updateFrames() {
        holderView.frame = CGRect(x: 0, y: 10, width: self.frame.size.width, height: self.frame.size.height)
        avatarImage.frame = CGRect(x: 0, y: 0, width: holderView.frame.size.width, height: holderView.frame.size.height * 0.2)
        nameLabel.frame = CGRect(x: 0, y: avatarImage.frame.origin.y + avatarImage.frame.size.height + 5, width: holderView.frame.size.width, height: 30)
        let nameLabelFrame = nameLabel.frame
        nameLabel.sizeToFit()
        nameLabel.frame = CGRect(x: nameLabelFrame.origin.x, y: nameLabelFrame.origin.y, width: holderView.frame.size.width, height: nameLabelFrame.size.height)
        separatorView.frame = CGRect(x: 10, y: nameLabel.frame.origin.y + nameLabel.frame.size.height + 5, width: holderView.frame.size.width - 20, height: 1)
        if countryView.isTextEmpty() {
            countryView.frame = .zero
        } else {
            countryView.updateFrames(frame: CGRect(x: 10, y: separatorView.frame.origin.y + separatorView.frame.size.height + 20, width: holderView.frame.size.width - 20, height: 30), imageWidthHeight: 30)
        }
        if emailView.isTextEmpty() {
            emailView.frame = .zero
        } else {
            emailView.updateFrames(frame: CGRect(x: 10, y: countryView.frame.origin.y + countryView.frame.size.height + 10, width: holderView.frame.size.width - 20, height: 30), imageWidthHeight: 30)
        }
        if phoneView.isTextEmpty() {
            phoneView.frame = .zero
        } else {
            phoneView.updateFrames(frame: CGRect(x: 10, y: emailView.frame.origin.y + emailView.frame.size.height + 10, width: holderView.frame.size.width - 20, height: 30), imageWidthHeight: 30)
        }
        if dobView.isTextEmpty() {
            dobView.frame = .zero
        } else {
            dobView.updateFrames(frame: CGRect(x: 10, y: phoneView.frame.origin.y + phoneView.frame.size.height + 10, width: holderView.frame.size.width - 20, height: 30), imageWidthHeight: 30)
        }
        if genderView.isTextEmpty() {
            genderView.frame = .zero
        } else {
            genderView.updateFrames(frame: CGRect(x: 10, y: dobView.frame.origin.y + dobView.frame.size.height + 10, width: holderView.frame.size.width - 20, height: 30), imageWidthHeight: 30)
        }
        if userNameView.isTextEmpty() {
            userNameView.frame = .zero
        } else {
            userNameView.updateFrames(frame: CGRect(x: 10, y: genderView.frame.origin.y + genderView.frame.size.height + 10, width: holderView.frame.size.width - 20, height: 30), imageWidthHeight: 30)
        }
        if passwordView.isTextEmpty() {
            passwordView.frame = .zero
        } else {
            passwordView.updateFrames(frame: CGRect(x: 10, y: userNameView.frame.origin.y + userNameView.frame.size.height + 10, width: holderView.frame.size.width - 20, height: 30), imageWidthHeight: 30)
        }
    }
    
    // MARK: Public setters
    func setName(_ name: String) {
        nameLabel.text = name
        updateFrames()
    }
    
    func setAvatarImage(_ imageUrl: URL, placeHolderImageName: String, errorImageName: String) {
        avatarImage.load(url: imageUrl, placeholder: UIImage(named: placeHolderImageName), errorImage: UIImage(named: errorImageName))
        updateFrames()
    }
    
    func setCountry(imageName: String, text: String) {
        countryView.setImage(systemName: imageName)
        countryView.setText(text: text)
        updateFrames()
    }
    
    func setEmail(imageName: String, text: String) {
        emailView.setImage(systemName: imageName)
        emailView.setText(text: text)
        updateFrames()
    }
    
    func setPhone(imageName: String, text: String) {
        phoneView.setImage(systemName: imageName)
        phoneView.setText(text: text)
        updateFrames()
    }
    
    func setDob(imageName: String, text: String) {
        dobView.setImage(systemName: imageName)
        dobView.setText(text: text)
        updateFrames()
    }
    
    func setGender(imageName: String, text: String) {
        genderView.setImage(systemName: imageName)
        genderView.setText(text: text)
        updateFrames()
    }
    
    func setUserName(imageName: String, text: String) {
        userNameView.setImage(systemName: imageName)
        userNameView.setText(text: text)
        updateFrames()
    }
    
    func setPassword(imageName: String, text: String) {
        passwordView.setImage(systemName: imageName)
        passwordView.setText(text: text)
        updateFrames()
    }
}
