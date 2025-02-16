import Foundation
import Combine
public class BDRContext: NSObject {
    public static let shared = BDRContext()
    
    private var app: BederrApp?
    private var currentUser: User?
    private var userProgram: UserProgram?
    
    public var coinsUser = CurrentValueSubject<Int,Never>(0)
    public var currentArea = CurrentValueSubject<Area,Never>(Area(uid: "", name: "Área Desconocida"))

    
    public func setBederrApp(_ app: BederrApp) {
        self.app = app
    }
    
    public func setUser(_ user: User) {
        self.currentUser = user
        self.currentArea.value = user.area ?? getApp().defaultArea
    }
    
    public func getUser() -> User? {
        return currentUser
    }
    
    public func setProgram(_ userProgram: UserProgram) {
        self.userProgram = userProgram
        self.coinsUser.value = userProgram.coins
    }
    
    public func updateCoins(_ coinSpend: Int) {
        guard let program = userProgram else { return }
     //   userProgram?.coins = (userProgram?.coins ?? 0) - coinSpend
        self.coinsUser.value = program.coins - coinSpend
    }
    
    public func getProgram() -> UserProgram? {
        return userProgram
    }
    
    public func updateExternalProgramCode(code: String) {
        userProgram?.externClientNumber = code
    }
    
    public func getApp() -> BederrApp {
        guard let app = app else {
            fatalError("Bederr App is needed for application")
        }
        return app
    }
}

public extension Bundle {
    var displayName: String {
        return object(forInfoDictionaryKey: "CFBundleName") as? String ?? "App"
    }
}


extension Notification {
    public static let userLogIn = Notification.Name("userLogIn")
    public static let userLogOut = Notification.Name("userLogOut")
    public static let filterSelect = Notification.Name("filterSelect")
    public static let changeArea = Notification.Name("changeArea")
}
