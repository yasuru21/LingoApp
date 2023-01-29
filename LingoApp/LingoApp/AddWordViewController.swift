//
//  AddWordViewController.swift
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

class AddWordViewController: UIViewController, UITextFieldDelegate {

    //all connections for the add word view
       
    var audioPlayer: AVAudioPlayer!
    @IBOutlet weak var partOfSpeechTextField: UITextField!
    @IBOutlet weak var definitionTextField: UITextField!
    @IBOutlet weak var wordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        partOfSpeechTextField.delegate = self
        definitionTextField.delegate = self
        wordTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func addWord(_ sender: Any){
        /*
         This function is what will be activated on a button pressand will take the word and save it to persistent storage.
        This will work in conjunction with AppDelegate as well as the WordModel.swift files to be able to successfully add the word to the array of words in the model and save the words to
         persistent storage.
         */
        let lAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let lDataModel = lAppDelegate.myWordData
        lDataModel.addWord(word: self.wordTextField.text!, partOfSpeech: self.partOfSpeechTextField.text!, defintion: self.definitionTextField.text!)
        
        if let lContainerTabBarController = self.tabBarController{
            let lSiblingViewController = lContainerTabBarController.viewControllers
            if let lTableViewController = lSiblingViewController?[0] as? TableViewController{
                lTableViewController.searchedWordObjects.append(WordObject(wWord: self.wordTextField.text!, wPartOfSpeech: self.partOfSpeechTextField.text!, wDefinition: self.definitionTextField.text!))
                if let lTableView = lTableViewController.view as? UITableView{
                    lTableView.reloadData()
                }
            }
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "notification_sound", ofType: "mp3")!))
            audioPlayer.play()
        }
        catch{
            print("function has gone wrong")
            print("notification not played")
        }
    }
    


}

