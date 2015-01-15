test:
    xcodebuild \
        -project iBeaconPeripheralSample.xcodeproj \
        -sdk iphonesimulator \
        -scheme iBeaconPeripheralSample \
        -configuration Debug \
        -destination 'platform=iOS Simulator,name=iPhone 6,0S=8.1' \
        clean build test