import ProjectDescription
import ProjectDescriptionHelpers

//let project = Project.app(name: "FootprintIOS",
//                          platform: .iOS,
//                          additionalTargets: ["FootprintIOSKit", "FootprintIOSUI"])
//

let projectName = "Footprint-iOS"

let project = Project(
    name: projectName,
    organizationName: projectName,
    targets: [
        Target(
            name: projectName,
            platform: .iOS,
            product: .app,
            bundleId: "com.\(projectName)",
//            infoPlist: "Info.plist",
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
//            infoPlist: "Info.plist",
            sources: ["Targets/FootprintIOS/Tests/**"],
            dependencies: [
                .target(name: projectName)
            ]
        )
    ]
)
