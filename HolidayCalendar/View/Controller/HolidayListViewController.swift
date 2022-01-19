//
//  HolidayListViewController.swift
//  HolidayCalendar
//
//  Created by mai nguyen on 1/18/22.
//

import UIKit

class HolidayListViewController: UIViewController {

    var isSearch : Bool = false
    let holidayVM = HolidayViewModel()

    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search..."
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        navigationItem.titleView = searchBar
        return searchBar
        
    }()
    
    let tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        setupBar()
        tableViewConfigureUI()
    }
    
    
    func tableViewConfigureUI() {
        view.addSubview(tableView)
        tableView.backgroundColor = .green
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: HolidayTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: HolidayTableViewCell.identifier)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo:searchBar.bottomAnchor)
        ])
    }
    
    func setupBar() {
        
        view.addSubview(searchBar)
        searchBar.delegate = self
        
        let navigationBar = self.navigationController!.navigationBar
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            searchBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: navigationBar.frame.height + 30),
            searchBar.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
 
    

}

extension HolidayListViewController :UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText.count == 0 {
                isSearch = false
            } else {
               isSearch = true
                self.holidayVM.getHolidayList(country:searchText) { _ in
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                }
            }
        }
    }
}

extension HolidayListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return holidayVM.listOfHoliday()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: HolidayTableViewCell.identifier) as? HolidayTableViewCell {
            cell.updateLabel(holidayDetail:  holidayVM.holidayModel?.response.holidays[indexPath.row])
            return cell
        }
        return UITableViewCell()
  
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}
