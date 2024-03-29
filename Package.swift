// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SmilesOcassionThemes",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SmilesOcassionThemes",
            targets: ["SmilesOcassionThemes"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/smilesiosteam/SmilesFontsManager.git", branch: "main"),
        .package(url: "https://github.com/smilesiosteam/SmilesUtilities.git", branch: "main"),
        .package(url: "https://github.com/smilesiosteam/SmilesSharedServices.git", branch: "main"),
        .package(url: "https://github.com/smilesiosteam/SmilesLanguageManager.git", branch: "main"),
        .package(url: "https://github.com/smilesiosteam/SmilesLoader.git", branch: "main"),
        .package(url: "https://github.com/smilesiosteam/SmilesBaseMainRequest.git", branch: "main"),
        .package(url: "https://github.com/smilesiosteam/SmilesOffers.git", branch: "main"),
        .package(url: "https://github.com/smilesiosteam/SmilesBanners.git", branch: "main"),
        .package(url: "https://github.com/smilesiosteam/SmilesStoriesManager.git", branch: "main")
    ],
    targets: [
        .target(
            name: "SmilesOcassionThemes",
            dependencies: [
                .product(name: "SmilesFontsManager", package: "SmilesFontsManager"),
                .product(name: "SmilesUtilities", package: "SmilesUtilities"),
                .product(name: "SmilesSharedServices", package: "SmilesSharedServices"),
                .product(name: "SmilesLanguageManager", package: "SmilesLanguageManager"),
                .product(name: "SmilesLoader", package: "SmilesLoader"),
                .product(name: "SmilesBaseMainRequestManager", package: "SmilesBaseMainRequest"),
                .product(name: "SmilesOffers", package: "SmilesOffers"),
                .product(name: "SmilesBanners", package: "SmilesBanners"),
                .product(name: "SmilesStoriesManager", package: "SmilesStoriesManager")
            ],
            resources: [
                .process("Resources")
            ]),
    ],swiftLanguageVersions: [.v5]
)
