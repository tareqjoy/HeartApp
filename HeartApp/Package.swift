//
//  Package.swift
//  HeartApp
//
//  Created by Tareq Joy on 20/5/20.
//  Copyright © 2020 Tareq Rahman Joy. All rights reserved.
//

import PackageDescription

let package = Package(
  name: "RxTestProject",
  dependencies: [
    .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "5.0.0")
  ],
  targets: [
    .target(name: "RxTestProject", dependencies: ["RxSwift", "RxCocoa"])
  ]
)
