import SwiftUI

struct FAQView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                FAQItem(
                    question: "What does the QR code contain?",
                    answer: "The QR code contains only your Celestial ID number — nothing else. It does not store personal data, passport details, or any sensitive information."
                )
                
                FAQItem(
                    question: "What happens when I scan the QR code?",
                    answer: "Your phone receives the Celestial ID from the QR code and uses it to link the verification process to your account. The QR itself does not provide any personal information."
                )
                
                FAQItem(
                    question: "How is my passport processed during verification?",
                    answer: "Your passport is scanned locally on your device. The data never leaves your phone. It's used only to generate a zero-knowledge proof confirming that your passport is valid."
                )
                
                FAQItem(
                    question: "Is any passport information stored?",
                    answer: "No. Passport data is never uploaded, never stored, and never shared. Only the zero-knowledge proof — a mathematical confirmation — is sent to the network."
                )
                
                FAQItem(
                    question: "Can someone misuse my QR code?",
                    answer: "No. The QR code only contains an ID number, not your personal info. Without your wallet and your device, no one can generate proofs on your behalf."
                )
                
                FAQItem(
                    question: "What happens if the proof submission fails?",
                    answer: "You can try again. Since all data stays on your device until the proof is sent, nothing is lost and no personal information is leaked."
                )
            }
            .padding(.horizontal, 4)
            .padding(.bottom, 20)
        }
        .background(.bgPrimary)
    }
}

private struct FAQItem: View {
    let question: String
    let answer: String
    
    var body: some View {
        CardContainer {
            VStack(alignment: .leading, spacing: 8) {
                Text(question)
                    .buttonLarge()
                    .foregroundStyle(.textPrimary)
                
                Text(answer)
                    .body4()
                    .foregroundStyle(.textSecondary)
            }
        }
    }
}

#Preview {
    FAQView()
}