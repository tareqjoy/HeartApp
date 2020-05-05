//
//  Tab1.swift
//  HeartApp
//
//  Created by Tareq Rahman Joy on 4/5/20.
//  Copyright © 2020 Tareq Rahman Joy. All rights reserved.
//

import Foundation

import UIKit
import JJFloatingActionButton



class Tab1: UIViewController{
    var lst = [InfoClass]()

    @IBOutlet weak var listView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        listView.dataSource = self
        listView.register(UINib(nibName:"InfoViewTableViewCell", bundle: nil), forCellReuseIdentifier: "reUsableCell")
        
        let actionButton = JJFloatingActionButton()
        
        view.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        
        actionButton.handleSingleActionDirectly = true
        let addItem = actionButton.addItem()
        addItem.action = { item in
            //self.performSegue(withIdentifier: "addItem", sender: self)

          
            self.performSegue(withIdentifier: "addItem", sender: self)
        }
             
            
        }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier  == "addItem" {
            let destination = segue.destination as! ActionViewController
            destination.delegate = self
        }
    }
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()

        if let tabBar = self.tabBarController?.tabBar {
            
            let safeAreaTop = CGFloat(0)//view.safeAreaInsets.top
            tabBar.frame.origin.y = safeAreaTop
            
           // tabBar.invalidateIntrinsicContentSize()
            
            let height = tabBar.frame.height
            
            listView.frame.origin.y = safeAreaTop + height
            
            
        }
    }
    
    
    
    
    
}


extension Tab1: AddDataToList{
    func addData(_ age: Int, _ name: String) {
        lst.append(InfoClass(age: age, name: name))
        listView.reloadData()
    }
    
    
}

extension Tab1: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        lst.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reUsableCell", for: indexPath) as! InfoViewTableViewCell
        cell.ageLabel.text = String(lst[indexPath.row].age)
        cell.nameLabel.text = lst[indexPath.row].name
        return cell
    }
    
    
}
