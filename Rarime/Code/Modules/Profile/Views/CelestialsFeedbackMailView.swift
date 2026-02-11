import MessageUI
import SwiftUI
import UIKit

struct CelestialsFeedbackMailView: UIViewControllerRepresentable {
    @Binding var isShowing: Bool

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var isShowing: Bool

        init(isShowing: Binding<Bool>) {
            _isShowing = isShowing
        }

        func mailComposeController(
            _ controller: MFMailComposeViewController,
            didFinishWith result: MFMailComposeResult,
            error: Error?
        ) {
            isShowing = false
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(isShowing: $isShowing)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<CelestialsFeedbackMailView>) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        
        // Celestials email configuration from Android
        vc.setToRecipients(["help@grndd.systems"])
        vc.setSubject("ZK Celestials ID Support")
        vc.setMessageBody("Hello Support Team,\n\n", isHTML: false)
        
        return vc
    }

    func updateUIViewController(
        _ uiViewController: MFMailComposeViewController,
        context: UIViewControllerRepresentableContext<CelestialsFeedbackMailView>
    ) {}
}