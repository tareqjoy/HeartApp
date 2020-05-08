//
//  AddDataToList.swift
//  HeartApp
//
//  Created by Tareq Rahman Joy on 5/5/20.
//  Copyright © 2020 Tareq Rahman Joy. All rights reserved.
//

import Foundation

protocol InfoEntityManage {
    func addData(_ age:Int, _ name: String )
    func updateData(_ age:Int, _ name: String, index i: Int)
    func deleteData(_ age:Int, _ name: String, index i: Int)
    func loadDataToList() -> [InfoClass]
}
