import SwiftUI

struct AuthView: View {
    @EnvironmentObject var viewModel: AuthViewModel

    @State private var email = ""
    @State private var password = ""
    @State private var isCreatingNewAccount = false

    var body: some View {
        NavigationView {
            VStack {
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }

                if isCreatingNewAccount {
                    Button("Sign Up") {
                        viewModel.signUp(email: email, password: password)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .clipShape(Capsule())
                } else {
                    Button("Sign In") {
                        viewModel.signIn(email: email, password: password)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .clipShape(Capsule())
                }

                Button(isCreatingNewAccount ? "Already have an account? Sign In" : "Need an account? Sign Up") {
                    isCreatingNewAccount.toggle()
                    viewModel.clearErrorMessage()
                }
                .padding()

                Spacer()
            }
            .navigationTitle(isCreatingNewAccount ? "Sign Up" : "Sign In")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            viewModel.clearErrorMessage()
        }
    }
}
