// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BDRUIComponents",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "BDRUIComponents",
            targets: ["BDRUIComponents"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/Juanpe/SkeletonView.git", from: "1.7.0"),
        .package(url: "https://github.com/hackiftekhar/IQKeyboardManager.git", from: "6.5.9"),
        .package(url: "https://github.com/marmelroy/PhoneNumberKit", from: "3.7.0"),
        .package(url: "https://github.com/kizitonwose/CountryPickerView.git", from: "3.3.0"),
        .package(path: "../BDRModel"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "BDRUIComponents",
            dependencies: ["BDRModel", "SkeletonView", "PhoneNumberKit", "CountryPickerView", .product(name: "IQKeyboardManagerSwift", package: "IQKeyboardManager")],
            resources: []
        ),
        .testTarget(
            name: "BDRUIComponentsTests",
            dependencies: ["BDRUIComponents", "BDRModel"]),
    ]
)
