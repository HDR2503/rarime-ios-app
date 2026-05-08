import Foundation

enum PassportTutorialStep: Int, CaseIterable {
    case removeCase, scanMrz, readNfc
    
    var title: LocalizedStringResource {
        switch self {
        case .removeCase: return "Remove Case"
        case .scanMrz: return "Scan Your Passport"
        case .readNfc: return "NFC Reader"
        }
    }
    
    var text: LocalizedStringResource {
        switch self {
        case .removeCase: return "Make sure you remove the case from the device"
        case .scanMrz: return "Scan your passport's first page inside the border"
        case .readNfc: return "Place your passport cover to the back of your phone"
        }
    }
    
    func image(_ isUSA: Bool = false) -> ImageResource {
        switch self {
        case .removeCase: return ImageResource(name: "celestial_case", bundle: .main)
        case .scanMrz: return ImageResource(name: "celestial_scan_passport", bundle: .main)
        case .readNfc: return ImageResource(name: "celestial_nfc", bundle: .main)
        }
    }
    
    var buttonText: LocalizedStringResource {
        switch self {
        case .removeCase, .scanMrz: return "Next"
        case .readNfc: return "Let's Scan"
        }
    }
}
