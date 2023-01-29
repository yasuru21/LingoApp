//
//  WordOfTheDayViewController.swift
//  LingoApp
//
//  Created by Michael Quinn on 4/16/21.
/*
 Michael Quinn - michquin@iu.edu
 Ian McLoud - imcloud@iu.edu
 Yash Asuru - yasuru@iu.edu
 */
//

import UIKit
import AVFoundation

class WordOfTheDayViewController: UIViewController {
   
    //all connections for the word of the day view
    var audioPlayer = AVAudioPlayer()
    @IBOutlet weak var wordDayLabel: UILabel!
    @IBOutlet weak var defDayLabel: UILabel!
    @IBOutlet weak var speechDayLabel: UILabel!
    @IBOutlet weak var shuffleBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func shuffleWord(_ sender: Any) {
        /*
         1. Instantiate the data model
         2. shuffle the word array
         3. randomly select a word from the array
         4. display the randomly chosen word
         */
        let lAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let lDataModel = lAppDelegate.myWordData
        
        let randomWord = lDataModel.wordData.randomElement()
        
        wordDayLabel.text = randomWord?.getWord()
        defDayLabel.text = randomWord?.getDefinition()
        speechDayLabel.text = randomWord?.getPartOfSpeech()

        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "notification_sound", ofType: "mp3")!))
            audioPlayer.play()
        }
        catch{
            print("notification not played")
        }
    }
    /*
     Button that allows a notification to be sent. Ths function sets the contents of the notification, specifies a time, and then sents a request upon a trigger to send the notification to a user
     I used the Apple Documentation on User Notifications - more specifically on how to schedule local notifications
     That can be found here: www.developer.apple.com/documentation/usernotifications/scheduling_a_notification_locally_from_your_app
     */
    @IBAction func turnONNotifications(_ sender: Any) {
        let content = UNMutableNotificationContent()
        content.title = "Lingo App"
        content.body = "Check out the word of the day and try shuffling!"
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        
        dateComponents.weekday = 2 //Mondays
        dateComponents.hour = 7 // 7am
        dateComponents.minute = 30 //minute 30
        
        //runs the notification every monday at 7:30am
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        
        //this runs the notifaction once 20 seconds after clicking the button. Use for testing purposes and demostration
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 20, repeats: false)
        
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if error != nil {
                
            }
        }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
