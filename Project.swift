import ProjectDescription
import ProjectDescriptionHelpers

protocol ProjectFactory {
    var projectName: String { get }
    var dependencies: [TargetDependency] { get }
    
    func generateTarget() -> [Target]
    func generateConfigurations() -> Settings
}

class BaseProjectFactory: ProjectFactory {
    let projectName: String = "Footprint-iOS"
    
    var dependencies: [TargetDependency] = [
        .external(name: "Moya"),
        .external(name: "SnapKit"),
        .external(name: "RxSwift"),
        .external(name: "Then"),
        .external(name: "ReactorKit"),
        .external(name: "RxCocoa"),
        .external(name: "RxDataSources"),
        .external(name: "RxGesture"),
        .external(name: "KakaoSDKCommon"),
        .external(name: "KakaoSDKAuth"),
        .external(name: "KakaoSDKUser"),
        .external(name: "NMapsMap"),
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
        "API_BASE_URL": "$(ROOT_URL)",
        "KAKAO_APP_KEY": "$(KAKAO_APP_KEY)",
        "LSApplicationQueriesSchemes": ["kakaokompassauth", "kakaolink"],
        "CFBundleURLTypes": ["CFBundleURLSchemes": ["kakao$(KAKAO_APP_KEY)"]],
        "NMFClientId": "$(NAVER_CLIENT_ID)"
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

    func generateConfigurations() -> Settings {
        Settings.settings(configurations: [
            .debug(name: "Develop", xcconfig: .relativeToRoot("FootprintIOS/FootprintIOS/Sources/Config/Develop.xcconfig")),
            .release(name: "Production", xcconfig: .relativeToRoot("FootprintIOS/FootprintIOS/Sources/Config/Production.xcconfig")),
        ])
    }

}

// MARK: - project
let factory = BaseProjectFactory()

let project: Project = .init(
    name: factory.projectName,
    organizationName: factory.projectName,
    settings: factory.generateConfigurations(),
    targets: factory.generateTarget()
)
