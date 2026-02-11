import SwiftUI
import MessageUI

enum MainTabs: Int, CaseIterable {
    case home, identity, scanQr, profile, contact
    
    var iconName: ImageResource {
        switch self {
        case .home: .homeLine
        case .identity: .passportLine
        case .scanQr: .qrScan2Line
        case .profile: .userLine
        case .contact: .chat2Line // email icon
        }
    }
    
    var activeIconName: ImageResource {
        switch self {
        case .home: .homeFill
        case .identity: .passportFill
        case .scanQr: .qrScan2Line
        case .profile: .userFill
        case .contact: .chat2Line
        }
    }
}

extension MainView {
    class ViewModel: ObservableObject {
        @Published var selectedTab: MainTabs = .home
        @Published var isQrCodeScanSheetShown = false
        @Published var isContactEmailSheetShown = false
        
        func selectTab(_ tab: MainTabs) {
            if tab == .contact {
                // Show email sheet instead of selecting tab
                isContactEmailSheetShown = true
            } else {
                selectedTab = tab
            }
        }
    }
}