import SwiftUI

struct LoginPage: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var containerOffset: CGFloat = 50
    @State private var topCircleScale: CGFloat = 0.5
    @State private var bottomCircleScale: CGFloat = 0.3
    @State private var topCircleOpacity: Double = 0.1
    @State private var bottomCircleOpacity: Double = 0.2
    @FocusState private var focusedField: Field?
    @Environment(\.colorScheme) var colorScheme

    enum Field: Hashable {
        case email
        case password
    }

    var body: some View {
        ZStack {
            // Gradient background
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(hex: "6366F1"),
                    Color(hex: "000")
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
                        .foregroundColor(Color.white.opacity(topCircleOpacity))
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
                        .foregroundColor(Color(hex: "6366F1").opacity(bottomCircleOpacity))
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
            VStack(spacing: 20) {
                // Header
                VStack(spacing: 5) {
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
                            .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 1)
                    }
                    Text("Transform Your Fitness Journey")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding(.top, 40)

                // Sign in text
                Text("Sign in to your Account")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 1)

                Text("Enter your email and password to log in")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .padding(.bottom, 20)

                // Glassmorphic container for form
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
                        .edgesIgnoringSafeArea(.bottom)

                    RoundedRectangle(cornerRadius: 24)
                        .foregroundColor(Color.white.opacity(0.05))
                        .padding(3)
                        .blur(radius: 8)
                        .edgesIgnoringSafeArea(.bottom)

                    // Form content
                    VStack(spacing: 15) {
                        // Email and Password fields
                        VStack(spacing: 20) {
                            // Email Field
                            ModernTextField(
                                title: "Email Address",
                                text: $email,
                                isTyping: focusedField == .email,
                                keyboardType: .emailAddress,
                                autocapitalization: .never
                            )
                            .focused($focusedField, equals: .email)
                            
                            // Password Field
                            ModernPasswordField(
                                title: "Password",
                                text: $password,
                                isTyping: focusedField == .password,
                                showPassword: $isPasswordVisible
                            )
                            .focused($focusedField, equals: .password)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 30)

                        // Log in Button
                        ModernButton(
                            title: "Log in",
                            isEnabled: !email.isEmpty && !password.isEmpty,
                            action: {
                                print("Login tapped")
                            }
                        )
                        .padding(.horizontal, 20)
                        .padding(.top, 10)

                        // Divider with "Or"
                        HStack {
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.white.opacity(0.4))
                            Text("Or")
                                .foregroundColor(.white.opacity(0.8))
                                .font(.caption)
                                .padding(.horizontal, 10)
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.white.opacity(0.4))
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)

                        // Social Login Buttons
                        SocialLoginButton(
                            icon: "g.circle.fill",
                            title: "Continue with Google",
                            action: {
                                print("Google login tapped")
                            }
                        )
                        .padding(.horizontal, 20)

                        SocialLoginButton(
                            icon: "applelogo",
                            title: "Continue with Apple",
                            action: {
                                print("Apple login tapped")
                            }
                        )
                        .padding(.horizontal, 20)

                        // Register link
                        Button(action: {
                            print("Register tapped")
                        }) {
                            Text("Don't have an account? Register here")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.9))
                                .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 1)
                        }
                        .padding(.bottom, 20)
                        .padding(.top, 10)
                    }
                }
                .offset(y: containerOffset)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .onAppear {
                    withAnimation(.spring()) {
                        containerOffset = 0
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .navigationBarBackButtonHidden(true)
        .onTapGesture {
            focusedField = nil
        }
    }
}

// Modern TextField Component (based on first code's design)
struct ModernTextField: View {
    let title: String
    @Binding var text: String
    var isTyping: Bool
    var keyboardType: UIKeyboardType = .default
    var autocapitalization: TextInputAutocapitalization = .sentences
    @State private var isValid: Bool = true
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            TextField("", text: $text)
                .padding(.leading, 16)
                .frame(height: 55)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(
                            isFocused ? Color(hex: "6366F1") : Color.white.opacity(0.3),
                            lineWidth: isFocused ? 2 : 1.5
                        )
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white.opacity(0.95))
                        )
                )
                .textFieldStyle(PlainTextFieldStyle())
                .focused($isFocused)
                .keyboardType(keyboardType)
                .textInputAutocapitalization(autocapitalization)
                .foregroundColor(.black)
                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
            
            Text(title)
                .padding(.horizontal, 8)
                .background(Color.white)
                .foregroundColor(isFocused ? Color(hex: "6366F1") : .gray)
                .font(.system(size: isFocused || !text.isEmpty ? 12 : 16, weight: isFocused ? .medium : .regular))
                .padding(.leading, 12)
                .offset(y: isFocused || !text.isEmpty ? -27 : 0)
                .onTapGesture {
                    isFocused = true
                }
        }
        .animation(.easeInOut(duration: 0.2), value: isFocused)
        .onChange(of: isTyping) { newValue in
            isFocused = newValue
        }
    }
}

// Modern Password Field Component
struct ModernPasswordField: View {
    let title: String
    @Binding var text: String
    var isTyping: Bool
    @Binding var showPassword: Bool
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            HStack {
                Group {
                    if showPassword {
                        TextField("", text: $text)
                    } else {
                        SecureField("", text: $text)
                    }
                }
                .padding(.leading, 16)
                .focused($isFocused)
                .foregroundColor(.black)
                
                Button(action: {
                    showPassword.toggle()
                }) {
                    Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(.gray)
                        .padding(.trailing, 16)
                        .font(.system(size: 16))
                }
            }
            .frame(height: 55)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(
                        isFocused ? Color(hex: "6366F1") : Color.white.opacity(0.3),
                        lineWidth: isFocused ? 2 : 1.5
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white.opacity(0.95))
                    )
            )
            .textFieldStyle(PlainTextFieldStyle())
            .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
            
            Text(title)
                .padding(.horizontal, 8)
                .background(Color.white)
                .foregroundColor(isFocused ? Color(hex: "6366F1") : .gray)
                .font(.system(size: isFocused || !text.isEmpty ? 12 : 16, weight: isFocused ? .medium : .regular))
                .padding(.leading, 12)
                .offset(y: isFocused || !text.isEmpty ? -27 : 0)
                .onTapGesture {
                    isFocused = true
                }
        }
        .animation(.easeInOut(duration: 0.2), value: isFocused)
        .onChange(of: isTyping) { newValue in
            isFocused = newValue
        }
    }
}

// Modern Button Component
struct ModernButton: View {
    let title: String
    let isEnabled: Bool
    let action: () -> Void
    @State private var isPressed = false
    @State private var shimmerOffset: CGFloat = -0.25
    
    var body: some View {
        Button(action: action) {
            ZStack {
                // Base gradient
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                isEnabled ? Color(hex: "6366F1") : Color.gray.opacity(0.6),
                                isEnabled ? Color(hex: "4338CA") : Color.gray.opacity(0.4)
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                
                // Shimmer effect
                if isEnabled {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.white.opacity(0.0),
                                    Color.white.opacity(0.1),
                                    Color.white.opacity(0.2),
                                    Color.white.opacity(0.1),
                                    Color.white.opacity(0.0)
                                ]),
                                startPoint: UnitPoint(x: shimmerOffset, y: shimmerOffset),
                                endPoint: UnitPoint(x: shimmerOffset + 1, y: shimmerOffset + 1)
                            )
                        )
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration: 2.0).repeatForever(autoreverses: false)) {
                                shimmerOffset = 1.25
                            }
                        }
                }
                
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .scaleEffect(isPressed ? 0.95 : 1.0)
            .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
        }
        .disabled(!isEnabled)
        .opacity(isEnabled ? 1.0 : 0.7)
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isPressed = pressing
            }
        }, perform: {})
    }
}

// Social Login Button Component
struct SocialLoginButton: View {
    let icon: String
    let title: String
    let action: () -> Void
    @State private var isPressed = false
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.white)
                    .font(.title2)
                Text(title)
                    .foregroundColor(.white)
                    .fontWeight(.medium)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(Color.white.opacity(0.1))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                    )
            )
            .scaleEffect(isPressed ? 0.95 : 1.0)
        }
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isPressed = pressing
            }
        }, perform: {})
    }
}



#Preview {
    LoginPage()
}
