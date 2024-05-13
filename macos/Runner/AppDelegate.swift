import Cocoa
import FlutterMacOS

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}
