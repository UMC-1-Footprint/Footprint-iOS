import ProjectDescription
import ProjectDescriptionHelpers

protocol ProjectFactory {
    var projectName: String { get }
    var dependencies: [TargetDependency] { get }
    
    func generateTarget() -> [Target]
//    func generateConfigurations() -> Settings
}

class BaseProjectFactory: ProjectFactory {
    let projectName: String = "Footprint-iOS"
    
    var dependencies: [TargetDependency] = [
        .external(name: "Moya"),
        .external(name: "SnapKit"),
        .external(name: "RxSwift"),
        .external(name: "Then"),
        .external(name: "ReactorKit"),
    ]
    
    func generateTarget() -> [Target] {
        [
            Target(
                name: projectName,
                platform: .iOS,
                product: .app,
                bundleId: "com.\(projectName)",
//                infoPlist: "Info.plist",
                sources: ["Targets/FootprintIOS/Sources/**"],
                resources: ["Targets/FootprintIOS/Resources/**"],
    //            headers: .headers(
    //                public: ["Sources/public/A/**", "Sources/public/B/**"],
    //                private: "Sources/private/**",
    //                project: ["Sources/project/A/**", "Sources/project/B/**"]
    //            ),
                dependencies: dependencies
            ),
            Target(
                name: "\(projectName)Tests",
                platform: .iOS,
                product: .unitTests,
                bundleId: "com.\(projectName)Tests",
//                infoPlist: "Info.plist",
                sources: ["Targets/FootprintIOS/Tests/**"],
                dependencies: [
                    .target(name: projectName)
                ]
            )
        ]
    }
    
//    func generateConfigurations() -> Settings {
//        <#code#>
//    }
//
}

// MARK: - project
let factory = BaseProjectFactory()

let project: Project = .init(
    name: factory.projectName,
    organizationName: factory.projectName,
    targets: factory.generateTarget()
)
