// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "PhotoMemo",
    platforms: [.iOS(.v17)],
    products: [
        .iOSApplication(
            name: "PhotoMemo",
            targets: ["PhotoMemo"],
            bundleIdentifier: "com.example.PhotoMemo",
            teamIdentifier: "",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder,
            accentColor: .preset(.blue),
            supportedDeviceFamilies: [ .phone, .pad ],
            supportedInterfaceOrientations: [ .portrait ]
        )
    ],
    targets: [
        .executableTarget(
            name: "PhotoMemo",
            path: "Sources/PhotoMemo"
        )
    ]
)
