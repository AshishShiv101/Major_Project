import SwiftUI

struct Splash: View {
    @State private var navigateToOnboarding = false
    @State private var iconScale: CGFloat = 0.8
    @State private var iconRotation: Double = 0
    @State private var textOpacity: Double = 0
    @State private var dividerHeight: CGFloat = 0

    var body: some View {
        NavigationStack {
            ZStack {
                // Improved gradient with better contrast
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(hex: "6366F1"), // Indigo-500
                       
                        Color(hex: "#000")  // Pink-500
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                HStack {
                    Image(systemName: "dumbbell.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                        .rotationEffect(.degrees(90 + iconRotation))
                        .scaleEffect(iconScale)

                    // Animated vertical divider
                    Rectangle()
                        .frame(width: 2, height: dividerHeight)
                        .foregroundColor(.white)

                    // ShapeShift text with fade-in animation
                    Text("ShapeShift")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .opacity(textOpacity)
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
                // Staggered animations
                withAnimation(.easeOut(duration: 0.8)) {
                    iconScale = 1.0
                }
                
                withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                    iconRotation = 10
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(.easeOut(duration: 0.6)) {
                        dividerHeight = 30
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    withAnimation(.easeOut(duration: 0.8)) {
                        textOpacity = 1.0
                    }
                }
                
                // Navigate after 3 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    navigateToOnboarding = true
                }
            }
        }
    }
}



struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        Splash()
    }
}
