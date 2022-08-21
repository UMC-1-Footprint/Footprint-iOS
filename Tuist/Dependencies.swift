//
//  Dependencies.swift
//  Config
//
//  Created by Sojin Lee on 2022/08/21.
//

import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: [
        .remote(url: "https://github.com/Moya/Moya.git", requirement: .upToNextMajor(from: "15.0.0")),
        .remote(url: "https://github.com/ReactiveX/RxSwift.git", requirement: .upToNextMinor(from: "6.5.0")),
        .remote(url: "https://github.com/ReactorKit/ReactorKit.git", requirement: .upToNextMinor(from: "3.2.0")),
        .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMinor(from: "5.0.0")),
        .remote(url: "https://github.com/devxoul/Then.git", requirement: .upToNextMinor(from: "3.0.0")),
    ],
    platforms: [.iOS]
)

//rxswift
//rxcocoa
//then
//snapkit
//reactorkit
//moya
