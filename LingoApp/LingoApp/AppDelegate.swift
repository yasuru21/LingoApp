//
//  AppDelegate.swift
//  LingoApp
//
//  Created by Michael Quinn on 4/29/21.
/*
 Michael Quinn - michquin@iu.edu
 Ian McLoud - imcloud@iu.edu
 Yash Asuru - yasuru@iu.edu
 */
//
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let myWordData: WordModel = WordModel()
    let reminderCell: TableViewCell = TableViewCell()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        /*
         app will check persistent storage location to see whether a file with our array of words and definitions is already present. If so it passes that array to the word model class and will construct cells accordingly. If not nothing will execute
         */
        
        do{
            
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
            let fileManager = FileManager.default
            let documentsNSURL = NSURL(fileURLWithPath: documentsPath)
            if let documentsURL = documentsNSURL.appendingPathComponent("modelData.plist") {
                let filePath = documentsURL.path
                if fileManager.fileExists(atPath: filePath) {
                    print("File Exists")
                    let modelData = try! Data(contentsOf: documentsURL)
                    let decodedModelData = try PropertyListDecoder().decode([WordObject].self, from: modelData)
                    myWordData.wordData = decodedModelData
                    print("--Successfully Copied Over Data--")

                }
                else {
                    print("File Doesn't Exist")
                }
            }
            else {
                print("Problem Finding Path")
            }
        }
        catch{
            print("something really ain't right")
        }
        /*
         This connects to the notification center and request permission to allow notifications to be sent locally.
         I used the Apple Documentation for User Notification - specifically requesting permission
         The link to that can be found here: www.developer.apple.com/documentation/usernotifications/asking_permission_to_use_notifications
         */
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("There was an error requesting access for notifications")
            }
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

