import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        installRootViewController()

        window?.makeKeyAndVisible()
        return true
    }

    private func installRootViewController() {
        let bordersViewController = RootViewController()
        let navigationController = UINavigationController(rootViewController: bordersViewController)
        window?.rootViewController = navigationController
    }

}
