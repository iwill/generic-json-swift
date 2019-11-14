Details about this file’s format at <http://keepachangelog.com/>. The change log is parsed automatically when minting releases through Fastlane, see `Fastlane/Fastfile`.

## [Unreleased]

- Conform `JSON` to `Hashable` [cjmconie]

## [2.0.0] - 2019-07-04

- Fix initialization from `NSNumber` booleans [cjmconie]
- Change `Float` number representation to `Double` [cjmconie]

## [1.2.1] - 2019-04-23

- Trivial release to change versioning tags

## [1.2.0] - 2019-02-13

- Allow initialization from nil and NSNull values [cjmconie]

## [1.1.4] - 2019-01-31

- Remove redundant “public” keyword from extensions [rudedogdhc]

## [1.1.3] - 2019-01-16

- Set explicit iOS Deployment Target [rudedogdhc]

## [1.1.2] - 2019-01-06

- Update podspec to always point to the latest tagged version [zoul]

## [1.1.1] - 2019-01-06

- First version with a changelog :)
- Add basic Swift Package Manager support [zoul]
- Switch to a platform-neutral build target [zoul]
- Add ability to query using a key path string [cjmconie]
- Add first version of JSON merging [cjmconie & zoul]
- Add support for macOS when distributed through CocoaPods [roznet]
