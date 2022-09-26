//
//  UserDetailsViewController.swift
//  Randomuser
//
//  Created by David Lopez on 19/9/22.
//

import Foundation
import UIKit

final class UserDetailsViewController: UIViewController {
    
    // MARK: Data
    private var user: UserModel = UserModel()
    
    // MARK: UI elements
    private var scrollView: UIScrollView = UIScrollView()
    private var userDetailsView: UserDetailsView = UserDetailsView()
    
    // MARK: Set-up
    override func viewDidLoad() {
        setUpScrollView()
        setUpUserDetailsView()
    }
 
    private func setUpScrollView() {
        scrollView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: scrollView.frame.height + 40)
        scrollView.isUserInteractionEnabled = true
        view.addSubview(scrollView)
    }
    
    private func setUpUserDetailsView() {
        userDetailsView = UserDetailsView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height))
        userDetailsView.isUserInteractionEnabled = false
        scrollView.addSubview(userDetailsView)
        populateUserDetailsView()
    }
    
    private func populateUserDetailsView() {
        userDetailsView.setName("\(user.name.firstName) \(user.name.lastName)")
        if let url = URL(string: user.picture.large) {
            userDetailsView.setAvatarImage(url, placeHolderImageName: "placeholder", errorImageName: "placeholder")
        }
        userDetailsView.setCountry(imageName: "flag", text: user.location.country)
        userDetailsView.setEmail(imageName: "envelope", text: user.email)
        userDetailsView.setPhone(imageName: "phone", text: user.phone)
        userDetailsView.setDob(imageName: "calendar", text: user.dob.getDateDisplay())
        userDetailsView.setGender(imageName: "g.circle", text: user.gender.capitalized)
        userDetailsView.setUserName(imageName: "person", text: user.login.username)
        userDetailsView.setPassword(imageName: "key", text: user.login.password)
    }
    
    // MARK: Public setters
    func setUser(_ user: UserModel) {
        self.user = user
    }
}
