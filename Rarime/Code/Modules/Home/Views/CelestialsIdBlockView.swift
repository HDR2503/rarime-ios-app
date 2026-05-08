import SwiftUI

struct CelestialsIdBlockView: View {
    var body: some View {
        Button(action: {
            if let url = URL(string: "https://celestials.id/") {
                UIApplication.shared.open(url)
            }
        }) {
            VStack(spacing: 16) {
                // Banner image - NO BACKGROUND
                Image("celestial_banner")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .frame(height: 500)
                
                // Text card with grey background
                HStack(alignment: .top, spacing: 0) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("CELESTIALS ID")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.textPrimary)
                        
                        Text("Explore more about the next\ngeneration of identity on the web.")
                            .font(.system(size: 14))
                            .foregroundStyle(.textSecondary)
                    }
                    
                    Spacer()
                    
                    Image(.arrowRightUpLine)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.textSecondary)
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.bgComponentPrimary)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    CelestialsIdBlockView()
        .padding()
        .background(.bgPrimary)
}
