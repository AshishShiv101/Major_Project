import SwiftUI

struct OnboardingView: View {
    @State private var currentCardIndex = 0
    @State private var circle1Offset = CGSize(width: -100, height: -200)
    @State private var circle2Offset = CGSize(width: 100, height: 200)
    @State private var circle1Color: Color = .white.opacity(0.3)
    @State private var circle2Color: Color = .white.opacity(0.3)
    @State private var navigateToLogin = false

    let cards = [
        CardData(icon: "carrot.fill", title: "Follow a balanced, nutrient-rich diet"),
        CardData(icon: "figure.yoga", title: "Perfect your form with focused technique training"),
        CardData(icon: "dumbbell.fill", title: "Ultimate Expert Workout Library")
    ]

    var body: some View {
        ZStack {
            // Gradient background
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: "8A62D7"), .white]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            // Animated circles in the background
            ZStack {
                Circle()
                    .frame(width: 150, height: 150)
                    .foregroundColor(circle1Color)
                    .offset(circle1Offset)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 5).repeatForever(autoreverses: true)) {
                            circle1Offset = CGSize(width: 100, height: 200)
                            circle1Color = Color(hex: "B693F9").opacity(0.3)
                        }
                    }
                    .onChange(of: circle1Offset) { newOffset in
                        // Change color based on vertical position for circle1
                        withAnimation {
                            circle1Color = newOffset.height > 0 ? Color(hex: "B693F9").opacity(0.3) : Color.white.opacity(0.3)
                        }
                    }

                Circle()
                    .frame(width: 200, height: 200)
                    .foregroundColor(circle2Color)
                    .offset(circle2Offset)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 6).repeatForever(autoreverses: true)) {
                            circle2Offset = CGSize(width: -100, height: -200)
                            circle2Color = Color.white.opacity(0.3)
                        }
                    }
                    .onChange(of: circle2Offset) { newOffset in
                        // Change color based on vertical position for circle2
                        withAnimation {
                            circle2Color = newOffset.height > 0 ? Color(hex: "B693F9").opacity(0.3) : Color.white.opacity(0.3)
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
                        .foregroundColor(.black)
                        .rotationEffect(.degrees(90))

                    Rectangle()
                        .frame(width: 1, height: 30)
                        .foregroundColor(.black)

                    Text("ShapeShift")
                        .font(.title)
                        .fontWeight(.regular)
                        .foregroundColor(.black)
                }
                .padding(.top, 20)

                Text("TAG LINE")
                    .font(.caption)
                    .foregroundColor(.black)
                    .padding(.bottom, 40)

                // Add space to shift cards down
                Spacer()
                    .frame(height: 50)

                ZStack {
                    ForEach(cards.indices.reversed(), id: \.self) { index in
                        CardView(
                            icon: cards[index].icon,
                            title: cards[index].title,
                            isVisible: currentCardIndex == index,
                            onSwipe: { direction in
                                // Move to the next card regardless of swipe direction
                                currentCardIndex = (currentCardIndex + 1) % cards.count
                            }
                        )
                        .zIndex(currentCardIndex == index ? 1 : 0)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 50)

                HStack {
                    ForEach(cards.indices, id: \.self) { index in
                        Circle()
                            .frame(width: 8, height: 8)
                            .foregroundColor(currentCardIndex == index ? Color(hex: "8A62D7") : .white)
                            .overlay(
                                Circle()
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    }
                }
                .padding(.vertical, 40)

                // Push the button to the bottom
                Spacer()

                // Next/Continue button (at the bottom)
                if currentCardIndex == cards.count - 1 {
                    // On the last card, show "Continue" with navigation to LoginPage
                    Button(action: {
                        navigateToLogin = true
                    }) {
                        Text("Continue")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "8A62D7"))
                            .cornerRadius(10)
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
                    // On other cards, show "Next" to cycle through cards
                    Button(action: {
                        withAnimation {
                            currentCardIndex = (currentCardIndex + 1) % cards.count
                        }
                    }) {
                        Text("Next")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "8A62D7"))
                            .cornerRadius(10)
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

struct CardData {
    let icon: String
    let title: String
}

enum SwipeDirection {
    case left
    case right
    case none
}

struct CardView: View {
    let icon: String
    let title: String
    let isVisible: Bool
    let onSwipe: (SwipeDirection) -> Void

    @State private var offset = CGSize.zero
    @State private var rotation = 0.0
    @State private var isSwiping = false

    var body: some View {
        ZStack {
            // Glassmorphic background
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.white.opacity(0.2))
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color.white.opacity(0.3))
                        .blur(radius: 30)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.white.opacity(0.5), Color.white.opacity(0.1)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
                .shadow(color: Color.black.opacity(0.05), radius: 15, x: 0, y: 5)

            // Inner highlight for glass sheen
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.white.opacity(0.1))
                .padding(2)
                .blur(radius: 5)

            VStack {
                // Icon in a circular background
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.black)
                    .padding(15)
                    .background(Circle().foregroundColor(Color(hex: "8A62D7").opacity(0.2)))

                // Title text
                Text(title.uppercased())
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    .padding(.bottom, 20)
            }
        }
        .frame(width: 300, height: 250)
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
                            // Animate card off-screen
                            withAnimation(.spring()) {
                                offset = CGSize(width: direction == .right ? 500 : -500, height: 0)
                                rotation = direction == .right ? 20 : -20
                                isSwiping = true
                            }
                            // Update card index after animation completes
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                onSwipe(direction)
                                offset = .zero
                                rotation = 0
                                isSwiping = false
                            }
                        } else {
                            // Reset position if swipe threshold not met
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


struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            OnboardingView()
        }
    }
}
