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
        .external(name: "RxCocoa")
    ]
    
    let infoPlist: [String: InfoPlist.Value] = [
        "CFBundleVersion": "1",
        "UILaunchStoryboardName": "LaunchScreen",
        "UIApplicationSceneManifest": [
            "UIApplicationSupportsMultipleScenes": false,
            "UISceneConfigurations": [
                "UIWindowSceneSessionRoleApplication": [
                    [
                        "UISceneConfigurationName": "Default Configuration",
                        "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                    ],
                ]
            ]
        ],
    ]
    
    func generateTarget() -> [Target] {
        [
            Target(
                name: projectName,
                platform: .iOS,
                product: .app,
                bundleId: "com.\(projectName)",
                infoPlist: .extendingDefault(with: infoPlist),
                sources: ["FootprintIOS/FootprintIOS/Sources/**"],
                resources: ["FootprintIOS/FootprintIOS/Resources/**"],
                dependencies: dependencies
            ),
            Target(
                name: "\(projectName)Tests",
                platform: .iOS,
                product: .unitTests,
                bundleId: "com.\(projectName)Tests",
                infoPlist: .default,
                sources: ["FootprintIOS/FootprintIOS/Tests/**"],
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
