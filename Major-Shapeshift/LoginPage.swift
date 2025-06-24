import SwiftUI

struct LoginPage: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: "8A62D7"), Color(hex: "D9D1F2")]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                VStack(spacing: 5) {
                    HStack {
                        Image(systemName: "dumbbell.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.black)
                            .rotationEffect(.degrees(90))
                        Rectangle()
                            .frame(width: 1, height: 40)
                            .foregroundColor(.black)
                        Text("ShapeShift")
                            .font(.title2)
                            .fontWeight(.regular)
                            .foregroundColor(.black)
                    }
                    Text("Tag Line")
                        .font(.caption)
                        .foregroundColor(.black)
                }
                .padding(.top, 40)
                
                // Sign in text
                Text("Sign in to your Account")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.leading, -80)
                
                Text("Enter your email and password to log in")
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .padding(.bottom, 30)
                    .padding(.leading, -100)
                
                // Single rectangle for Email, Password, Log in, Continue buttons, and Register text
                ZStack {
                    Rectangle()
                        .fill(Color.white.opacity(0.6))
                        .cornerRadius(50)
                        .padding(.horizontal, 0)
                        .padding(.bottom, -60)
                    
                    
                    VStack(spacing: 15) {
                        // Email and Password fields
                        VStack(spacing: 15) {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Enter Email")
                                    .font(.caption)
                                    .foregroundColor(Color(hex: "#6C7278"))
                                    .padding(.top, 50) // Increased top margin for "Enter Email"
                                TextField("", text: $email)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .foregroundColor(.black)
                            }
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Enter Password")
                                    .font(.caption)
                                    .foregroundColor(Color(hex: "#6C7278"))
                                HStack {
                                    if isPasswordVisible {
                                        TextField("", text: $password)
                                    } else {
                                        SecureField("", text: $password)
                                    }
                                    Button(action: {
                                        isPasswordVisible.toggle()
                                    }) {
                                        Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .foregroundColor(.black)
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        // Log in Button
                        Button(action: {}) {
                            Text("Log in")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(hex: "8A62D7"))
                                .cornerRadius(10)
                        }
                        .padding(.horizontal, 20)
                        
                        // Divider with "Or"
                        HStack {
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray)
                            Text("Or")
                                .foregroundColor(.gray)
                                .padding(.horizontal, 10)
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal, 20)
                        
                        Button(action: {}) {
                            HStack {
                                Image(systemName: "g.circle.fill")
                                    .foregroundColor(.blue)
                                Text("Continue with Google")
                                    .foregroundColor(.black)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                        }
                        .padding(.horizontal, 20)
                        
                        Button(action: {}) {
                            HStack {
                                Image(systemName: "applelogo")
                                    .foregroundColor(.black)
                                Text("Continue with Apple")
                                    .foregroundColor(.black)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                        }
                        .padding(.horizontal, 20)
                        
                        // Register link inside the rectangle
                        Button(action: {}) {
                            Text("Don't have account? Register here")
                                .font(.subheadline)
                                .foregroundColor(.black)
                        }
                        .padding(.bottom, 10)
                    }
                    .padding(.vertical, 20)
                }
                
                Spacer()
            }
        }
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
