import Foundation

@MainActor
class BankConnectionViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var error: String?
    @Published var connectUrl: String?
    
    func initiateConnection(for user: User) async {
        isLoading = true
        error = nil
        
        do {
            let customerId = try await SaltEdgeService.shared.createCustomer(
                identifier: user.email
            )
            let url = try await SaltEdgeService.shared.createConnectSession(
                customerSecret: customerId
            )
            connectUrl = url
        } catch {
            self.error = error.localizedDescription
        }
        
        isLoading = false
    }
} 