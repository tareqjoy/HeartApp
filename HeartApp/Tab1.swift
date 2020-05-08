//
//  Tab1.swift
//  HeartApp
//
//  Created by Tareq Rahman Joy on 4/5/20.
//  Copyright © 2020 Tareq Rahman Joy. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import JJFloatingActionButton



class Tab1: UIViewController{
    var lst = [InfoClass]()
    
    @IBOutlet weak var listView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lst = loadDataToList()
        
        listView.dataSource = self
        listView.delegate = self
        listView.register(UINib(nibName:"InfoViewTableViewCell", bundle: nil), forCellReuseIdentifier: "reUsableCell")
        
        let actionButton = JJFloatingActionButton()
        
        view.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        
        actionButton.handleSingleActionDirectly = true
        let addItem = actionButton.addItem()
        addItem.action = { item in
            
            self.performSegue(withIdentifier: "addItem", sender: nil)
        }
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier  == "addItem" {
            let destination = segue.destination as! ActionViewController
            destination.delegate = self
            
            if let safeSender = sender {
                let tupl = safeSender as! (Int, InfoClass)
                let infoId = tupl.0
                let info = tupl.1
                destination.info = info
                destination.infoId = infoId
            }
        }
    }
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        
        if let tabBar = self.tabBarController?.tabBar {
            
            let safeAreaTop = CGFloat(0)//view.safeAreaInsets.top
            tabBar.frame.origin.y = safeAreaTop
            
            
            
            let height = tabBar.frame.height
            
            listView.frame.origin.y = safeAreaTop + height
            
            
        }
    }
    func loadDataToList() -> [InfoClass]{
        var infoData : [InfoClass] = []
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return infoData
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchReq = NSFetchRequest<NSFetchRequestResult> (entityName: "Info")
        
        do {
            let result = try managedContext.fetch(fetchReq)
            for data in result as! [NSManagedObject] {
                let age =  data.value(forKey: "age") as! Int
                let name = data.value(forKey: "name") as! String
                infoData.append(InfoClass(age: age, name: name))
            }
        } catch {
            print("error")
        }
        
        return infoData
    }
    
    
    
    
}


extension Tab1: AddDataToList{
    func addData(_ age: Int, _ name: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let infoEntity = NSEntityDescription.entity(forEntityName: "Info", in: managedContext)!
        
        let info = NSManagedObject(entity: infoEntity, insertInto: managedContext)
        info.setValue(age, forKey: "age")
        info.setValue(name, forKey: "name")
        
        do {
            try managedContext.save()
            lst.append(InfoClass(age: age, name: name))
            listView.reloadData()
        } catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    func updateData(_ age: Int, _ name: String, index i: Int) {
        
        let oldInfo = lst[i]
        let oldAge = oldInfo.age
        let oldName = oldInfo.name
        
        if (oldInfo.age != age || oldInfo.name != name) {
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchReq : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Info")
            fetchReq.predicate = NSPredicate(format: "age = %@ AND name = %@", String(oldAge), oldName)
            do {
                let test = try managedContext.fetch(fetchReq)
                
                let objUp = test[0] as! NSManagedObject
                objUp.setValue(age, forKey: "age")
                objUp.setValue(name, forKey: "name")
                
                do {
                    try managedContext.save()
                    lst[i].age = age
                    lst[i].name = name
                    listView.reloadData()
                } catch {
                    print(error)
                }
            } catch {
                print(error)
            }
        }
    }
    
    
    
}

extension Tab1: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        lst.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reUsableCell", for: indexPath) as! InfoViewTableViewCell
        let info = lst[indexPath.row] 
        cell.ageLabel.text = String(info.age)
        cell.nameLabel.text = info.name
        return cell
    }
    
    
}

extension Tab1: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        
        
        let info = lst[indexPath.row] 
        let message = "Age: " + String(info.age) + "\nName: " + String(info.name)
        let alert = UIAlertController(title: "Information", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Edit", style: UIAlertAction.Style.default, handler: { UIAlertAction in
            self.performSegue(withIdentifier: "addItem", sender: (indexPath.row, info))
        }))
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        
        self.present(alert, animated: true, completion: nil)
        
    }
}
