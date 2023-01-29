//
//  WordModel.swift
//  LingoApp
//
//  Created by Michael Quinn on 4/16/21.
/*
 Michael Quinn - michquin@iu.edu
 Ian McLoud - imcloud@iu.edu
 Yash Asuru - yasuru@iu.edu
 */
//

import Foundation

class WordModel {
    /*
    *creating array to save all the words
    *write function to take the words and save it to a file
    *add function to call write function
     */
    var wordData: [WordObject] = []
    
    func addWord(word: String, partOfSpeech: String, defintion: String){
        /*
         creates a WordObject and then appends it to a our array
         calls saveModel() at very end of implementation
         */
        self.wordData.append(WordObject(wWord: word, wPartOfSpeech: partOfSpeech, wDefinition: defintion))
        saveModel()
    }
    
    func saveModel(){
        /*
         function is called everytime a new word is added to array
         function re saves wordData by writing over old data
         */
        
        do{
           
            let fileManager = FileManager.default
            
            let documentsURL = try fileManager.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let currentData = wordData
            let encodedModelData = try PropertyListEncoder().encode(currentData)
            let documentsPath = documentsURL.appendingPathComponent("modelData.plist")
            
            print("File Path: ")
            print(documentsPath)
            try encodedModelData.write(to: documentsPath)
            print("--Successful File Save--")
            
        }
        catch{
            print("Unsucessful save: Model")
        }
    }
}

class WordObject: NSObject, NSCoding, Codable {
    /*
    *Takes words and encodes them to secure coding and saves
    content.
     */
    var myWord: String
    var myPartOfSpeech: String
    var myDefinition: String
    init(wWord: String, wPartOfSpeech: String, wDefinition: String){
        self.myWord = wWord
        self.myPartOfSpeech = wPartOfSpeech
        self.myDefinition = wDefinition
    }
    
    func getWord() -> String{
        return self.myWord
    }
    
    func getPartOfSpeech() -> String{
        return self.myPartOfSpeech
    }
    
    func getDefinition() -> String{
        return self.myDefinition
    }
    
    func encode(with coder: NSCoder) {
        /*
         encoder
         */
        do{
            try self.encode(to: NSCoder.self as! Encoder)
        }
        catch{
            print("--Encode Failed--")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
