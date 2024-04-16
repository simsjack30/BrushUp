import Foundation
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var errorMessage: String? = nil

    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if error != nil {
                self?.errorMessage = "Failed to sign in. Please check your credentials."
            } else {
                self?.isAuthenticated = true
                self?.errorMessage = nil
            }
        }
    }
    
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.errorMessage = "Failed to create account. \(error.localizedDescription)"
            } else {
                print("User created successfully")
                self?.isAuthenticated = true
                self?.errorMessage = nil
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            isAuthenticated = false
            print("User signed out successfully")
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
        }
    }
    
    func clearErrorMessage() {
        errorMessage = nil
    }
}
