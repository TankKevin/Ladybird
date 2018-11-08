//
//  MediaTypeEnum.swift
//  Worm
//
//  Created by 谭凯文 on 2018/4/5.
//  Copyright © 2018年 Tan Kevin. All rights reserved.
//

import Foundation

enum MediaType: String {
    case movie
    case book
    case music
    
    var maxNum: Int {
        switch self {
        case .movie:
            return 400
        case .book:
            return 150
        case .music:
            return 300
        }
    }
    
    
    func getInfoStrings(from doubanID: Int) throws -> [String] {
        // Using doubanID, get the url of certain page, store the data to a long string and split the string using regex to a string array, finally, return the array.
        
        // Get url
        let url = URL(string: "https://\(self.rawValue).douban.com/people/\(doubanID)/collect?start=0&sort=time&rating=all&filter=all&mode=list")!
        
        // Get data
        var resultData = Data()
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            if let error = error {
                print(error)
                
            }
            
            if let data = data {
                resultData = data
                
            }
            
        }
        
        task.resume()
        
        // Get string
        var totalInfo = String(bytes: resultData, encoding: String.Encoding.utf8)!
        while totalInfo == "" {
            // Make the current thread sleep for a while, if not. The downloaded data wouldn't be fetched and the rest of codes will be processed.
            
            
            Thread.sleep(forTimeInterval: 0.01)
            
            
            totalInfo = String(bytes: resultData, encoding: String.Encoding.utf8)!
        }
        
        
        // Split the string and make an array
        let regex = try NSRegularExpression(pattern: "<li id=\"list((.|\n)*?)</li>", options: [])
        let capturedMatches = regex.matches(in: totalInfo, range: NSRange(location: 0, length: totalInfo.count))
//        print("This page's match number: \(capturedMatches.count)")
        
        var capturedStrings = [String]()
        
        for match in capturedMatches {
            
            // Use range [instead of range(at: 1)] to get "<li id=\"list" and "</li>" included.
            let nsRange = match.range
//            print(nsRange)

            // Must make string index instead of using range barely
            let range = Range(nsRange, in: totalInfo)!
//            print(range)
            
            let finalString = String(totalInfo[range])
//            print(finalString)

            capturedStrings.append(finalString)
            
            
        }
        
        return capturedStrings
    }
    
    func translateStringsToMedias(from strings: [String]) throws -> [Media] {
        // Get information from 'strings', use for-in loop to scan every string to get media instances and return [Media]
        var resultMedias = [Media]()
        
        
        // Get regular expression patterns
        var patterns = [String]()
        // name pattern
        patterns.append("/\">\n                        (.*?)\n                    </a>")
        // date pattern
        patterns.append("\n                (.*?)\n                </div>\n            </div>\n            <div")
        // star pattern
        patterns.append("<span class=\"rating(.*?)-t\"></span>&nbsp;&nbsp;")
        // comment pattern
        patterns.append("<div class=\"comment\">\n                    ((.|\n)*?)\n                    \n                </div>")
        
        
        // Search every captured string
        for str in strings {
            let media = Media()
            
            for patternIndex in 0..<patterns.count {
                let mediaRegex = try NSRegularExpression(pattern: patterns[patternIndex], options: [])
                
                let mediaMatches = mediaRegex.matches(in: str, options: [], range: NSRange(location: 0, length: str.count))
                
                // If not matches!
                if mediaMatches.count == 0 {
                    switch patternIndex {
                    case 2:
                        media.star = String(stars: 0)
                    case 3:
                        media.comment = "没有短评"
                    default:
                        fatalError()
                    }
                    
                    continue
                }
                
                // If matches!
                let nsRange = mediaMatches[0].range(at: 1)
                
                let range = Range(nsRange, in: str)!
                
                let finalString = String(str[range])
//                print(finalString)
                
                switch patternIndex {
                case 0:
                    media.name = finalString
                case 1:
                    media.date = finalString
                case 2:
                    media.star = String(stars: Int(finalString)!)
                case 3:
                    media.comment = finalString
                default:
                    fatalError()
                }
            }
            
            resultMedias.append(media)
            
        }
    
        return resultMedias
    }
    
    
    func getMedias(from doubanID: Int) throws -> [Media] {
        
        let infoStrings = try getInfoStrings(from: doubanID)
        
        let resultMedias = try translateStringsToMedias(from: infoStrings)
        
        
        
        return resultMedias
    }
    
    
   
}
