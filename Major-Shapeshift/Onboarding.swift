import SwiftUI

// Update CardData to support both system and custom images
struct CardData {
    let icon: String
    let isSystemImage: Bool // New property to differentiate between system and custom images
    let title: String
}

struct OnboardingView: View {
    @State private var currentCardIndex = 0
    @State private var topCircleScale: CGFloat = 0.5
    @State private var bottomCircleScale: CGFloat = 0.3
    @State private var topCircleOpacity: Double = 0.1
    @State private var bottomCircleOpacity: Double = 0.2
    @State private var navigateToLogin = false

    let cards = [
        CardData(icon: "Diet", isSystemImage: false, title: "Follow a balanced, nutrient-rich diet"),
        CardData(icon: "Posture", isSystemImage: false, title: "Perfect your form with focused technique training"),
        CardData(icon: "Gym", isSystemImage: false, title: "Ultimate Expert Workout Library")
    ]

    var body: some View {
        ZStack {
            // Gradient background
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(hex: "6366F1"), // Indigo-500
                    Color(hex: "#000")
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            // Animated circles
            GeometryReader { geometry in
                ZStack {
                    Circle()
                        .frame(width: 80, height: 80)
                        .foregroundColor(Color(hex: "fff").opacity(topCircleOpacity))
                        .position(
                            x: geometry.size.width * 0.22,
                            y: geometry.size.height * 0.30
                        )
                        .scaleEffect(topCircleScale)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 2.5)) {
                                topCircleScale = 1.2
                                topCircleOpacity = 0.3
                            }
                        }

                    Circle()
                        .frame(width: 100, height: 100)
                        .foregroundColor(Color(hex: "6366f1").opacity(bottomCircleOpacity))
                        .position(
                            x: geometry.size.width * 0.78,
                            y: geometry.size.height * 0.65
                        )
                        .scaleEffect(bottomCircleScale)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 3).delay(0.8)) {
                                bottomCircleScale = 1.1
                                bottomCircleOpacity = 0.4
                            }
                        }
                }
            }

            // Main content
            VStack {
                // Header
                HStack {
                    Image(systemName: "dumbbell.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                        .rotationEffect(.degrees(90))

                    Rectangle()
                        .frame(width: 2, height: 30)
                        .foregroundColor(.white)

                    Text("ShapeShift")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                .padding(.top, 20)

                Text("TAG LINE")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.bottom, 40)

                Spacer()
                    .frame(height: 50)

                ZStack {
                    ForEach(cards.indices.reversed(), id: \.self) { index in
                        CardView(
                            icon: cards[index].icon,
                            isSystemImage: cards[index].isSystemImage, // Pass the new property
                            title: cards[index].title,
                            isVisible: currentCardIndex == index,
                            onSwipe: { direction in
                                withAnimation(.easeInOut(duration: 0.8)) {
                                    topCircleScale = direction == .right ? 1.4 : 1.0
                                    bottomCircleScale = direction == .left ? 1.3 : 0.9
                                    topCircleOpacity = direction == .right ? 0.4 : 0.25
                                    bottomCircleOpacity = direction == .left ? 0.5 : 0.35
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                    withAnimation(.easeInOut(duration: 1.0)) {
                                        topCircleScale = 1.2
                                        bottomCircleScale = 1.1
                                        topCircleOpacity = 0.3
                                        bottomCircleOpacity = 0.4
                                    }
                                }
                                
                                currentCardIndex = (currentCardIndex + 1) % cards.count
                            }
                        )
                        .zIndex(currentCardIndex == index ? 1 : 0)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 50)

                // Page indicators
                HStack {
                    ForEach(cards.indices, id: \.self) { index in
                        Circle()
                            .frame(width: 8, height: 8)
                            .foregroundColor(currentCardIndex == index ? .white : Color.white.opacity(0.4))
                            .overlay(
                                Circle()
                                    .stroke(Color.white.opacity(0.6), lineWidth: 1)
                            )
                    }
                }
                .padding(.vertical, 40)

                Spacer()

                // Next/Continue button
                if currentCardIndex == cards.count - 1 {
                    Button(action: {
                        navigateToLogin = true
                    }) {
                        Text("Continue")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.vertical, 16)
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .foregroundColor(Color(hex: "6366F1"))
                                    .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                            )
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)
                    .background(
                        NavigationLink(
                            destination: LoginPage(),
                            isActive: $navigateToLogin
                        ) {
                            EmptyView()
                        }
                        .hidden()
                    )
                } else {
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            topCircleScale = 1.3
                            bottomCircleScale = 1.2
                            topCircleOpacity = 0.35
                            bottomCircleOpacity = 0.45
                        }
                        
                        withAnimation {
                            currentCardIndex = (currentCardIndex + 1) % cards.count
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation(.easeInOut(duration: 0.8)) {
                                topCircleScale = 1.2
                                bottomCircleScale = 1.1
                                topCircleOpacity = 0.3
                                bottomCircleOpacity = 0.4
                            }
                        }
                    }) {
                        Text("Next")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.vertical, 16)
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .foregroundColor(Color(hex: "6366F1"))
                                    .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                            )
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct CardView: View {
    let icon: String
    let isSystemImage: Bool // New property
    let title: String
    let isVisible: Bool
    let onSwipe: (SwipeDirection) -> Void

    @State private var offset = CGSize.zero
    @State private var rotation = 0.0
    @State private var isSwiping = false

    var body: some View {
        ZStack {
            // Glassmorphic background
            RoundedRectangle(cornerRadius: 24)
                .foregroundColor(Color.white.opacity(0.15))
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .foregroundColor(Color(hex: "6366F1")).opacity(0.5)
                        .blur(radius: 30)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.white.opacity(0.6),
                                    Color.white.opacity(0.2)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1.5
                        )
                )
                .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 10)

            RoundedRectangle(cornerRadius: 24)
                .foregroundColor(Color.white.opacity(0.05))
                .padding(3)
                .blur(radius: 8)

            VStack(spacing: 20) {
                // Conditionally render system image or custom image
                if isSystemImage {
                    Image(systemName: icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color(hex: "6366F1"))
                        .padding(20)
                        
                } else {
                    Image(icon) // Use custom image from asset catalog
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding(20)
                       
                }

                Text(title.uppercased())
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 1)
            }
            .padding(.vertical, 10)
        }
        .frame(width: 300, height: 280)
        .offset(x: offset.width, y: offset.height)
        .rotationEffect(.degrees(rotation))
        .opacity(isVisible && !isSwiping ? 1 : 0)
        .animation(.spring(), value: isVisible)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    if isVisible {
                        offset = gesture.translation
                        rotation = Double(gesture.translation.width / 20)
                    }
                }
                .onEnded { gesture in
                    if isVisible {
                        let swipeThreshold: CGFloat = 100
                        let direction: SwipeDirection

                        if gesture.translation.width > swipeThreshold {
                            direction = .right
                        } else if gesture.translation.width < -swipeThreshold {
                            direction = .left
                        } else {
                            direction = .none
                        }

                        if direction != .none {
                            withAnimation(.spring()) {
                                offset = CGSize(width: direction == .right ? 500 : -500, height: 0)
                                rotation = direction == .right ? 20 : -20
                                isSwiping = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                onSwipe(direction)
                                offset = .zero
                                rotation = 0
                                isSwiping = false
                            }
                        } else {
                            withAnimation(.spring()) {
                                offset = .zero
                                rotation = 0
                            }
                        }
                    }
                }
        )
    }
}

enum SwipeDirection {
    case left
    case right
    case none
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            OnboardingView()
        }
    }
}


