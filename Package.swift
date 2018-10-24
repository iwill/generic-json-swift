// swift-tools-version:4.0
import PackageDescription

let package = Package(
  name: "GenericJSON",
  products: [
    .library(
      name: "GenericJSON",
      targets: ["GenericJSON"]),
  ],
  dependencies: [],
  targets: [
    .target(
      name: "GenericJSON",
      dependencies: [],
      path: "GenericJSON"
    ),
    .testTarget(
      name: "GenericJSONTests",
      dependencies: ["GenericJSON"],
      path: "GenericJSONTests"
    )
  ]
)
