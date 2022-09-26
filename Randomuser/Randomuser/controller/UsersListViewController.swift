//
//  UsersViewController.swift
//  Randomuser
//
//  Created by David Lopez on 19/9/22.
//

import Foundation
import UIKit

final class UsersListViewController: UIViewController, UINavigationControllerDelegate {
    
    // MARK: Data
    private let service = RandomUserService()
    private var users: [UserModel] = []
    private var lastPageFetched: Int = 1
    private var resultsSeed: String? = nil
    
    // MARK: UI elements
    private var loadingView: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
    private var usersTableView: UITableView = UITableView()
    
    // MARK: Table view properties
    private var numberOfCellsPerRow: Int = 2
    private var tableViewRowHeight: CGFloat = 120
    
    // MARK: Set-up
    override func viewDidLoad() {
        setupTitle()
        setUpTableView()
        setUpLoadingView()
        addOptionsMenu()
        fetchRandomUsers()
    }
    
    private func setupTitle() {
        self.title = "RandomUser"
    }
    
    private func setUpLoadingView() {
        loadingView = UIActivityIndicatorView(style: .medium)
        loadingView.center = self.view.center
        view.addSubview(loadingView)
    }
    
    private func showLoadingView() {
        loadingView.startAnimating()
        loadingView.isHidden = false
        self.view.bringSubviewToFront(loadingView)
    }
    
    private func hideLoadingView() {
        loadingView.stopAnimating()
        loadingView.isHidden = true
    }
    
    private func setUpTableView() {
        usersTableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        usersTableView.separatorStyle = .none
        usersTableView.tableFooterView = UIView()
        usersTableView.allowsSelection = false
        usersTableView.register(UserCell.self, forCellReuseIdentifier: UserCell.reuseId)
        view.addSubview(usersTableView)
        usersTableView.dataSource = self
        usersTableView.delegate = self
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.userTapped(recognizer:)))
        usersTableView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func addOptionsMenu() {
        let saveSeedItem = UIAction(title: "Save Seed", image: UIImage(systemName: "arrow.down.to.line.compact"), handler: saveSeedHandler(action:))
        let reuseSeedItem = UIAction(title: "Reuse Seed", image: UIImage(systemName: "arrow.counterclockwise.circle"), handler: reuseSeedHandler(action:))
        let clearSeedItem = UIAction(title: "Clear Seed", image: UIImage(systemName: "trash"), handler: clearSavedSeedHandler(action:))
        let menu = UIMenu(title: "Options", children: [saveSeedItem, reuseSeedItem, clearSeedItem])
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, image: UIImage(systemName: "text.justify"), primaryAction: nil, menu: menu)
    }
    
    private func saveSeedHandler(action: UIAction) -> Void {
        if let resultsSeed = self.resultsSeed {
            RandomUserDefaults.saveSeed(seed: resultsSeed)
            let alert = UIAlertController(title: "Seed Saved", message: "", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        let alert = UIAlertController(title: "Error", message: "Erro saving seed", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func reuseSeedHandler(action: UIAction) -> Void {
        if !RandomUserDefaults.isSeedSaved() {
            let alert = UIAlertController(title: "Error", message: "No seed saved", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else if let savedSeed = RandomUserDefaults.retrieveSeed() {
            self.users.removeAll()
            self.lastPageFetched = 1
            self.resultsSeed = savedSeed
            fetchRandomUsers()
        } else {
            let alert = UIAlertController(title: "Error", message: "Error retrieving seed", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func clearSavedSeedHandler(action: UIAction) -> Void {
        RandomUserDefaults.clearSeed()
        let alert = UIAlertController(title: "Seed cleared", message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
                                    
    // MARK: Fetch users
    private func fetchRandomUsers() {
        showLoadingView()
        view.isUserInteractionEnabled = false
        DispatchQueue.global(qos: .background).async {
            self.service.fetchRandomUsersPage(page: self.lastPageFetched, seed: self.resultsSeed) { result in
                DispatchQueue.main.async {
                    self.hideLoadingView()
                    self.view.isUserInteractionEnabled = true
                    switch result {
                        case .success(let response):
                            self.handleRandomUsersFetched(response: response)
                        case .failure(let failure):
                            self.handleServiceFailures(withError: failure)
                    }
                }
            }
        }
    }
    
    private func handleRandomUsersFetched(response: ResponseModel) {
        self.lastPageFetched += 1
        self.users.append(contentsOf: response.results)
        self.usersTableView.reloadData()
        self.resultsSeed = response.info.seed
    }
    
    private func handleServiceFailures(withError error: Error) {
        hideLoadingView()
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.destructive, handler: retryAfterError(action:)))
        if self.lastPageFetched > 1 {
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    private func retryAfterError(action: UIAlertAction) {
        fetchRandomUsers()
    }
    
    private func getUserFirstNames(at: IndexPath) -> [String] {
        var firstNames: [String] = []
        for index in 0...numberOfCellsPerRow - 1 {
            if let user = users[safe: at.row * numberOfCellsPerRow + index] {
                firstNames.append(user.name.firstName)
            }
        }
        return firstNames
    }
    
    private func getUserLastNames(at: IndexPath) -> [String] {
        var lastNames: [String] = []
        for index in 0...numberOfCellsPerRow - 1 {
            if let user = users[safe: at.row * numberOfCellsPerRow + index] {
                lastNames.append(user.name.lastName)
            }
        }
        return lastNames
    }
    
    private func getUserImageUrls(at: IndexPath) -> [String] {
        var lastNames: [String] = []
        for index in 0...numberOfCellsPerRow - 1 {
            if let user = users[safe: at.row * numberOfCellsPerRow + index] {
                lastNames.append(user.picture.large)
            }
        }
        return lastNames
    }
    
    
    // MARK: Navigation
    private func navigateToUserDetails(user: UserModel) {
        if let detailsViewController: UserDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "UserDetails") as? UserDetailsViewController {
            detailsViewController.setUser(user)
            self.navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
    
    private func getUserFromCGPoint(_ point: CGPoint, cell: UserCell, indexPath: IndexPath) -> UserModel? {
        var user: UserModel?
        let widthOffset = cell.frame.size.width / CGFloat(numberOfCellsPerRow)
        for index in 0...numberOfCellsPerRow {
            if point.x > widthOffset * CGFloat(index) && point.x <= widthOffset * CGFloat(index + 1) {
                user = users[safe: indexPath.row * numberOfCellsPerRow + index]
            }
        }
        return user
    }
}

// MARK: UITableView
extension UsersListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count / numberOfCellsPerRow
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableViewRowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: UserCell = tableView.dequeueReusableCell(withIdentifier: UserCell.reuseId) as? UserCell else {
            return UITableViewCell()
        }
        cell.setupView(numberOfCells: self.numberOfCellsPerRow, width: self.usersTableView.frame.width, height: self.tableViewRowHeight)
        cell.setUserNames(firstNames: getUserFirstNames(at: indexPath), lastNames: getUserLastNames(at: indexPath))
        cell.setUserImages(imageUrls: getUserImageUrls(at: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row  == (users.count / numberOfCellsPerRow) - 3 {
            fetchRandomUsers()
        }
    }
    
    @objc func userTapped(recognizer: UITapGestureRecognizer) {
        if let indexPath = usersTableView.indexPathForRow(at: recognizer.location(in: usersTableView)), let cell = usersTableView.cellForRow(at: indexPath) as? UserCell {
            if let userSelected = getUserFromCGPoint(recognizer.location(in: cell), cell: cell, indexPath: indexPath) {
                navigateToUserDetails(user: userSelected)
            }
        }
    }
}
