//
//  Device.swift
//  imHome
//
//  Created by Kevin Xu on 2/9/15. Updated on 6/20/15.
//  Copyright (c) 2015 Alpha Labs, Inc. All rights reserved.
//

import Foundation
import UIKit


public extension NSBundle {
    
    var applicationVersionNumber: String {
        if let version = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String {
            return version
        }
        return "Version Number Not Available"
    }
    
    var applicationBuildNumber: String {
        if let build = NSBundle.mainBundle().infoDictionary?["CFBundleVersion"] as? String {
            return build
        }
        return "Build Number Not Available"
    }
}


// MARK: - Device Structure
struct Device {

    // MARK: - Singletons

    static var CurrentDevice: UIDevice {
        struct Singleton {
            static let device = UIDevice.currentDevice()
        }
        return Singleton.device
    }

    static var CurrentDeviceVersion: Float {
        
        struct Singleton {
            static let version = Float(UIDevice.currentDevice().systemVersion)
        }
        return Singleton.version!
    }

    static var CurrentDeviceHeight: CGFloat {
        struct Singleton {
            static let height = UIScreen.mainScreen().bounds.size.height
        }
        return Singleton.height
    }

    // MARK: - Device Idiom Checks

    static var PHONE_OR_PAD: String {
        if isPhone() {
            return "iPhone"
        } else if isPad() {
            return "iPad"
        }
        return "Not iPhone nor iPad"
    }

    static var DEBUG_OR_RELEASE: String {
        #if DEBUG
            return "Debug"
        #else
            return "Release"
        #endif
    }

    static var SIMULATOR_OR_DEVICE: String {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            return "Simulator"
        #else
            return "Device"
        #endif
    }


    static func isPhone() -> Bool {
        return CurrentDevice.userInterfaceIdiom == .Phone
    }

    static func isPad() -> Bool {
        return CurrentDevice.userInterfaceIdiom == .Pad
    }

    static func isDebug() -> Bool {
        return DEBUG_OR_RELEASE == "Debug"
    }

    static func isRelease() -> Bool {
        return DEBUG_OR_RELEASE == "Release"
    }

    static func isSimulator() -> Bool {
        return SIMULATOR_OR_DEVICE == "Simulator"
    }

    static func isDevice() -> Bool {
        return SIMULATOR_OR_DEVICE == "Device"
    }

    // MARK: - Device Version Checks

    enum Versions: Float {
        case Five = 5.0
        case Six = 6.0
        case Seven = 7.0
        case Eight = 8.0
        case Nine = 9.0
    }

    static func isVersion(version: Versions) -> Bool {
        return CurrentDeviceVersion >= version.rawValue && CurrentDeviceVersion < (version.rawValue + 1.0)
    }

    static func isVersionOrLater(version: Versions) -> Bool {
        return CurrentDeviceVersion >= version.rawValue
    }

    static func isVersionOrEarlier(version: Versions) -> Bool {
        return CurrentDeviceVersion < (version.rawValue + 1.0)
    }

    static var CURRENT_VERSION: String {
        return "\(CurrentDeviceVersion)"
    }

    // MARK: iOS 5 Checks

    static func IS_OS_5() -> Bool {
        return isVersion(.Five)
    }

    static func IS_OS_5_OR_LATER() -> Bool {
        return isVersionOrLater(.Five)
    }

    static func IS_OS_5_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.Five)
    }

    // MARK: iOS 6 Checks

    static func IS_OS_6() -> Bool {
        return isVersion(.Six)
    }

    static func IS_OS_6_OR_LATER() -> Bool {
        return isVersionOrLater(.Six)
    }

    static func IS_OS_6_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.Six)
    }

    // MARK: iOS 7 Checks

    static func IS_OS_7() -> Bool {
        return isVersion(.Seven)
    }

    static func IS_OS_7_OR_LATER() -> Bool {
        return isVersionOrLater(.Seven)
    }

    static func IS_OS_7_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.Seven)
    }

    // MARK: iOS 8 Checks

    static func IS_OS_8() -> Bool {
        return isVersion(.Eight)
    }

    static func IS_OS_8_OR_LATER() -> Bool {
        return isVersionOrLater(.Eight)
    }

    static func IS_OS_8_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.Eight)
    }

    // MARK: iOS 9 Checks

    static func IS_OS_9() -> Bool {
        return isVersion(.Nine)
    }

    static func IS_OS_9_OR_LATER() -> Bool {
        return isVersionOrLater(.Nine)
    }

    static func IS_OS_9_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.Nine)
    }

    // MARK: - Device Size Checks

    enum Heights: CGFloat {
        case Inches_3_5 = 480
        case Inches_4 = 568
        case Inches_4_7 = 667
        case Inches_5_5 = 736
    }

    static func isSize(height: Heights) -> Bool {
        return CurrentDeviceHeight == height.rawValue
    }

    static func isSizeOrLarger(height: Heights) -> Bool {
        return CurrentDeviceHeight >= height.rawValue
    }

    static func isSizeOrSmaller(height: Heights) -> Bool {
        return CurrentDeviceHeight <= height.rawValue
    }

    static var CURRENT_SIZE: String {
        if IS_3_5_INCHES() {
            return "3.5 Inches"
        } else if IS_4_INCHES() {
            return "4 Inches"
        } else if IS_4_7_INCHES() {
            return "4.7 Inches"
        } else if IS_5_5_INCHES() {
            return "5.5 Inches"
        }
        return "\(CurrentDeviceHeight) Points"
    }

    // MARK: Retina Check

    static func IS_RETINA() -> Bool {
        return UIScreen.mainScreen().respondsToSelector("scale")
    }

    // MARK: 3.5 Inch Checks

    static func IS_3_5_INCHES() -> Bool {
        return isPhone() && isSize(.Inches_3_5)
    }

    static func IS_3_5_INCHES_OR_LARGER() -> Bool {
        return isPhone() && isSizeOrLarger(.Inches_3_5)
    }

    static func IS_3_5_INCHES_OR_SMALLER() -> Bool {
        return isPhone() && isSizeOrSmaller(.Inches_3_5)
    }

    // MARK: 4 Inch Checks

    static func IS_4_INCHES() -> Bool {
        return isPhone() && isSize(.Inches_4)
    }

    static func IS_4_INCHES_OR_LARGER() -> Bool {
        return isPhone() && isSizeOrLarger(.Inches_4)
    }

    static func IS_4_INCHES_OR_SMALLER() -> Bool {
        return isPhone() && isSizeOrSmaller(.Inches_4)
    }

    // MARK: 4.7 Inch Checks

    static func IS_4_7_INCHES() -> Bool {
        return isPhone() && isSize(.Inches_4_7)
    }

    static func IS_4_7_INCHES_OR_LARGER() -> Bool {
        return isPhone() && isSizeOrLarger(.Inches_4_7)
    }

    static func IS_4_7_INCHES_OR_SMALLER() -> Bool {
        return isPhone() && isSizeOrLarger(.Inches_4_7)
    }

    // MARK: 5.5 Inch Checks

    static func IS_5_5_INCHES() -> Bool {
        return isPhone() && isSize(.Inches_5_5)
    }

    static func IS_5_5_INCHES_OR_LARGER() -> Bool {
        return isPhone() && isSizeOrLarger(.Inches_5_5)
    }

    static func IS_5_5_INCHES_OR_SMALLER() -> Bool {
        return isPhone() && isSizeOrLarger(.Inches_5_5)
    }

    // MARK: - International Checks

    static var CURRENT_REGION: String {
        return NSLocale.currentLocale().objectForKey(NSLocaleCountryCode) as! String
    }
}