import UIKit
import Firebase

final class UserDataStore {
    private static let _shared = UserDataStore()
    private init() { }
    
    public static var sharedInstance: UserDataStore { return _shared }
    public let firebaseAPI = APIClient()
    public var currentUser: User!
    
    public var currentUserString: String {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else { return "Unable to get UID" }
        return uid
    }
    
    public var tasks = [Task]()
    
    var profilePicture: UIImage!
    var validUsernames = [String]()
    
    func setupStore() {
        tasks.removeAll()
        if currentUser.tasks != nil { currentUser.tasks?.removeAll() }
    }
    
    func updateUserScore() {
        currentUser.experiencePoints += 1
        currentUser.numberOfTasksCompleted += 1
    }
}
