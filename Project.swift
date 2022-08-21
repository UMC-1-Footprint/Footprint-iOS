import ProjectDescription
import ProjectDescriptionHelpers

//let project = Project.app(name: "FootprintIOS",
//                          platform: .iOS,
//                          additionalTargets: ["FootprintIOSKit", "FootprintIOSUI"])
//

protocol ProjectFactory {
    var projectName: String { get }
//    var dependencies: [TargetDependency] { get }
    
    func generateTarget() -> [Target]
//    func generateConfigurations() -> Settings
}

class BaseProjectFactory: ProjectFactory {
    let projectName: String = "Footprint-iOS"
    
//    var dependencies: [TargetDependency] = [
//        .external(name: "Moya")
//    ]
    
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
                dependencies: [
                    /* Target dependencies can be defined here */
                    /* .framework(path: "framework") */
                ]
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


let factory = BaseProjectFactory()

let project: Project = .init(name: factory.projectName, organizationName: factory.projectName, targets: factory.generateTarget())
