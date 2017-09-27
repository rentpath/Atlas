import PackageDescription

let package = Package(
    name: "Atlas",
    exclude: [
        "AtlasTests",
        "AtlasTV",
        "AtlasTVTests",
        "fastlane",
        "AtlasOSX",
        "AtlasOSXTests"
    ]
)
