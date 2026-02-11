import SwiftUI

struct NavBarView: View {
    @Binding var selectedTab: MainTabs
    @Binding var isQrCodeScanSheetShown: Bool
    @Binding var isContactEmailSheetShown: Bool
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(MainTabs.allCases, id: \.self) { item in
                NavBarTabItem(tab: item, isActive: selectedTab == item)
                    .onTapGesture {
                        switch item {
                        case .scanQr:
                            isQrCodeScanSheetShown = true
                        case .contact:
                            isContactEmailSheetShown = true
                        default:
                            selectedTab = item
                        }
                        FeedbackGenerator.shared.impact(.light)
                    }
            }
        }
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity, alignment: .bottom)
    }
}

struct NavBarTabItem: View {
    let tab: MainTabs
    let isActive: Bool
    
    var body: some View {
        Image(isActive ? tab.activeIconName : tab.iconName)
            .iconLarge()
            .frame(width: 48, height: 40)
            .background(isActive ? .bgComponentPrimary : .clear)
            .foregroundStyle(isActive ? .textPrimary : .textPlaceholder)
            .cornerRadius(12)
    }
}

#Preview {
    NavBarView(
        selectedTab: .constant(.home),
        isQrCodeScanSheetShown: .constant(false),
        isContactEmailSheetShown: .constant(false)
    )
}