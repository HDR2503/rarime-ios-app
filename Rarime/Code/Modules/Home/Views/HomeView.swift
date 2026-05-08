import Alamofire
import BigInt
import SwiftUI
import Web3

private enum HomeRoute: String, Hashable {
    case notifications
}

struct HomeView: View {
    @EnvironmentObject private var notificationManager: NotificationManager
    @EnvironmentObject private var mainViewModel: MainView.ViewModel
    @EnvironmentObject private var passportManager: PassportManager

    @StateObject var viewModel = ViewModel()
    @StateObject var hiddenKeysViewModel = HiddenKeysViewModel()

    @State private var path: [HomeRoute] = []
    @State private var selectedWidget: HomeWidget? = nil
    @State private var isOnboardingPresented = false

    @Namespace private var recoveryNamespace
    @Namespace private var hiddenKeysNamespace
    @Namespace private var likenessNamespace
    @Namespace private var freedomToolNamespace
    @Namespace private var earnNamespace
    @Namespace private var claimTokensNamespace

    var body: some View {
        NavigationStack(path: $path) {
            content
                .navigationDestination(for: HomeRoute.self) { route in
                    switch route {
                    case .notifications:
                        NotificationsView(onBack: { path.removeLast() })
                            .environment(\.managedObjectContext,
                                         notificationManager.pushNotificationContainer.viewContext)
                            .navigationBarBackButtonHidden()
                    }
                }
                .task { await viewModel.fetchBalance() }
                .task { await hiddenKeysViewModel.loadUser() }
        }
    }

    @ViewBuilder
    private var content: some View {
        ZStack {
            switch selectedWidget {
            case .recovery:
                RecoveryMethodView(
                    animation: namespace(for: .recovery),
                    onClose: { selectedWidget = nil }
                )

        
            case .freedomTool:
                PollsView(
                    onClose: { selectedWidget = nil },
                    animation: namespace(for: .freedomTool)
                )

            case .likeness:
                LikenessView(
                    onClose: { selectedWidget = nil },
                    animation: namespace(for: .likeness)
                )

            case .earn:
                EarnRmoView(
                    balance: viewModel.pointsBalance,
                    onClose: { selectedWidget = nil },
                    animation: namespace(for: .earn)
                )
                .environmentObject(viewModel)

            default:
                mainLayoutContent
            }

            HomeOnboardingView(
                isPresented: isOnboardingPresented,
                onComplete: {
                    isOnboardingPresented = false
                    AppUserDefaults.shared.isHomeOnboardingCompleted = true
                }
            )
            .transition(.identity)
            .zIndex(1)
        }
        .animation(
            .interpolatingSpring(stiffness: 100, damping: 15),
            value: selectedWidget
        )
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                isOnboardingPresented = !AppUserDefaults.shared.isHomeOnboardingCompleted
            }
        }
    }

    @ViewBuilder
    private var mainLayoutContent: some View {
        MainViewLayout {
            VStack(spacing: 0) {
                header
                
                // ТІЛЬКИ Celestials ID block
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        CelestialsIdBlockView()
                            .padding(.horizontal, 20)
                            .padding(.top, 8)
                    }
                    .padding(.bottom, 20)
                }
            }
            .background(.bgPrimary)
        }
    }

    @ViewBuilder
    private var header: some View {
        HStack(alignment: .center, spacing: 8) {
            Text("Hi")
                .subtitle4()
                .foregroundStyle(.textSecondary)
            
            Text(passportManager.passport?.displayedFirstName.components(separatedBy: " ").first?.capitalized ?? "Celestial")
                .subtitle4()
                .foregroundStyle(.textPrimary)
                .lineLimit(1)

            Spacer()
            
            // Notifications ВИМКНЕНО (як в Android закоментовано)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 16)
        .background(Color.bgPrimary)
    }

    private func namespace(for key: HomeWidget) -> Namespace.ID {
        switch key {
        case .earn: return earnNamespace
        case .freedomTool: return freedomToolNamespace
        case .hiddenKeys: return hiddenKeysNamespace
        case .recovery: return recoveryNamespace
        case .likeness: return likenessNamespace
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(MainView.ViewModel())
        .environmentObject(PassportManager())
        .environmentObject(NotificationManager())
        .environmentObject(LikenessManager())
        .environmentObject(ConfigManager())
        .environmentObject(PollsViewModel())
}
