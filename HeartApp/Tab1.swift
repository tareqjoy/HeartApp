//
//  Tab1.swift
//  HeartApp
//
//  Created by Tareq Rahman Joy on 4/5/20.
//  Copyright © 2020 Tareq Rahman Joy. All rights reserved.
//

import Foundation

import UIKit

class Tab1: UIViewController{
    var lst = [String]()

    @IBOutlet weak var listView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 1...100
        {
            lst.append("Cell : " + String(i))
        }
        
        listView.dataSource = self
        print("here tab 1")
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews(){
        
        
        let height = self.tabBarController?.tabBar.frame.height
        
        listView.frame.origin.y = height ?? 0
    }
    
    
    
}


extension Tab1: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        lst.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reUsableCell", for: indexPath)
        cell.textLabel?.text = lst[indexPath.row]
        return cell
    }
    
    
}
