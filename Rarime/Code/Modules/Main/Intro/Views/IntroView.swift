import SwiftUI

struct IntroView: View {
    @EnvironmentObject private var userManager: UserManager
    @EnvironmentObject private var securityManager: SecurityManager
    @EnvironmentObject private var likenessManager: LikenessManager
    @EnvironmentObject private var walletManager: WalletManager

    var onFinish: () -> Void

    private let animationOffset: CGFloat = 64
    private let animationDelay: CGFloat = 0.4

    @State private var isInitialAnimationActive = true
    @State private var contentOpacity: Double = 0.0


    var body: some View {
        content
            .background(.bgPrimary, ignoresSafeAreaEdges: .all)
    }

    var content: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                Spacer()
                Image(.rarime)
                    .square(96)
                    .foregroundStyle(Gradients.gradientFirst)
                    .padding(.all, 44)
                    .background(.baseBlack)
                    .clipShape(RoundedRectangle(cornerRadius: 48))
                    .offset(y: isInitialAnimationActive ? 0 : (geometry.size.height / 2 - geometry.size.height * 0.7))
                Spacer()
                VStack(spacing: 8) {
                    Text("Welcome to ZK-KYC celestials id")
                        .subtitle4()
                        .foregroundStyle(.textSecondary)
                    Text("Based on Rarime")
                        .h1()
                        .foregroundStyle(.textPrimary)
                }
                .padding(.top, 28)
                .opacity(contentOpacity)
                .offset(y: isInitialAnimationActive ? animationOffset : 0)
                Spacer()
                AppButton(
                    text: "Start",
                    action: { createNewUser() }
                )
                .controlSize(.large)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(.horizontal, 48)
                .padding(.bottom, 24)
                .opacity(contentOpacity)
                .offset(y: isInitialAnimationActive ? animationOffset : 0)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + animationDelay) {
                    withAnimation(.interpolatingSpring(stiffness: 44, damping: 10)) {
                        isInitialAnimationActive = false
                        contentOpacity = 1.0
                    }
                }
            }
        }
    }
    private func createNewUser() {
        do {
            try userManager.createNewUser()
            guard let user = userManager.user else {
                throw Errors.userCreationFailed
            }

            try user.save()
            LoggerUtil.common.info("New user created: \(userManager.ethereumAddress ?? "", privacy: .public)")

            walletManager.privateKey = user.secretKey
            securityManager.disablePasscode()
            likenessManager.postInitialization()

            onFinish()
        } catch {
            userManager.user = nil
            LoggerUtil.common.error("failed to create new user: \(error.localizedDescription, privacy: .public)")
            AlertManager.shared.emitError(.userCreationFailed)
        }
    }
}

#Preview {
    IntroView(onFinish: {})
        .environmentObject(UserManager.shared)
        .environmentObject(SecurityManager.shared)
        .environmentObject(LikenessManager.shared)
        .environmentObject(WalletManager.shared)
}
