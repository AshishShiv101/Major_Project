import SwiftUI

struct Splash: View {
    @State private var navigateToOnboarding = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Gradient background from purple (8A62D7) to white
                LinearGradient(
                    gradient: Gradient(colors: [Color(hex: "8A62D7"), .white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea() // Ensures the gradient fills the entire screen

                HStack {
                    Image(systemName: "dumbbell.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.black)
                        .rotationEffect(.degrees(90))

                    // Vertical divider
                    Rectangle()
                        .frame(width: 1, height: 30)
                        .foregroundColor(.black)

                    // ShapeShift text
                    Text("ShapeShift")
                        .font(.title)
                        .fontWeight(.regular)
                        .foregroundColor(.black)
                }
                .background(
                    NavigationLink(
                        destination: OnboardingView(),
                        isActive: $navigateToOnboarding
                    ) {
                        EmptyView()
                    }
                    .hidden()
                )
            }
            .onAppear {
                // Delay navigation by 3 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    navigateToOnboarding = true
                }
            }
        }
    }
}

// Extension to support hex colors in SwiftUI

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        Splash()
    }
}
