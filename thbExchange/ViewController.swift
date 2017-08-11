//
//  ViewController.swift
//  thbExchange
//
//  Created by kuanhuachen on 2017/8/11.
//  Copyright © 2017年 kuanhuachen. All rights reserved.
//

import UIKit
import Alamofire
import Kanna


class ViewController: UIViewController {
    
    var shows: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        scrapeNYCMetalScene()
        scrapeBangkok()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func scrapeNYCMetalScene() -> Void {
        
        //http://rate.bot.com.tw/xrt?Lang=zh-TW 台灣銀行
        //http://nycmetalscene.com metal
        
        Alamofire.request("http://rate.bot.com.tw/xrt?Lang=zh-TW").responseString { response in
            print("\(response.result.isSuccess)")
            if let html = response.result.value {
//                self.parseHTML(html: html)
                self.testParseHTML(html: html)
            }
        }
    }
    
    
    func scrapeBangkok() -> Void {
        
        //http://rate.bot.com.tw/xrt?Lang=zh-TW 台灣銀行
        //http://nycmetalscene.com metal
        
        Alamofire.request("http://www.bbl.com.tw/exrate.asp").responseString { response in
            print("check for true or false , \(response.result.isSuccess)")
            if let html = response.result.value {
//                self.parseHTML(html: html)
                self.testParseHTML2(html: html)
            }
        }
    }
    
    
    func scrapeSuperRich() -> Void {
        
        //http://rate.bot.com.tw/xrt?Lang=zh-TW 台灣銀行
        //http://nycmetalscene.com metal
        
        Alamofire.request("http://www.bbl.com.tw/exrate.asp").responseString { response in
            
            print("superRich Boolean , \(response.result.isSuccess)")
            if let html = response.result.value {
                
                self.testParseHTML3(html: html)
            }
        }
    }
    
    
    func parseHTML(html: String) {

        if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
            
            // Search for nodes by CSS selector
            for show in doc.css("td[id^='Text']") {
                
                // Strip the string of surrounding whitespace.
                let showString = show.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                
                // All text involving shows on this page currently start with the weekday.
                // Weekday formatting is inconsistent, but the first three letters are always there.
                let regex = try! NSRegularExpression(pattern: "^(mon|tue|wed|thu|fri|sat|sun)", options: [.caseInsensitive])
                
                if regex.firstMatch(in: showString, options: [], range: NSMakeRange(0, showString.characters.count)) != nil {
                    shows.append(showString)
                    print("\(showString)\n")
                }
            }
        }
    }
    
    
    func testParseHTML(html: String) {
        
        if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
            
            // Search for nodes by CSS selector
            
                // Strip the string of surrounding whitespace.
                let showString = doc.at_xpath("/html/body/div[1]/main/div[4]/table/tbody/tr[12]/td[2]/class")?.text!
//                    .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            
//                print ("@@@@@", showString)
            
            for rate in doc.xpath("/html/body/div[1]/main/div[4]/table/tbody/tr[12]/td[2]") {
                
                print ("台灣銀行現金買入", rate.text!)
                
            }
            
            
            for rate in doc.xpath("/html/body/div[1]/main/div[4]/table/tbody/tr[12]/td[3]") {
                
                print ("台灣銀行現金賣出", rate.text!)
                
            }
            
            }
        }
    
    func testParseHTML2(html: String) {
        
        if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {

            
            for rate in doc.xpath("//div[@id='container']/center/table/tr[6]/td[2]") {
                
                print ("盤谷銀行現金買入", rate.text!)
                
            }
            
            for rate in doc.xpath("//div[@id='container']/center/table/tr[6]/td[3]") {
                
                print ("盤谷銀行現金賣出", rate.text!)
                
            }
            
        }
    }
    
    func testParseHTML3(html: String) {
        
        if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
            
            
            for rate in doc.xpath("//div[@id='container']/center/table/tr[6]/td[2]") {
                
                print ("superRich現金買入", rate.text!)
                
            }
            
            for rate in doc.xpath("//div[@id='container']/center/table/tr[6]/td[3]") {
                
                print ("superRich現金賣出", rate.text!)
                
            }
            
        }
    }

}

//*[@id="container"]/center/table/tbody/tr[6]/td[2]

//*[@id="print-table"]/tbody[15]/tr/td[3]/div/div/span


///html/body/div[1]/main/div[4]/table/tbody/tr[12]/td[2]

///html/body/div[1]/main/div[4]/table/tbody/tr[12]/td[2]

//html/body/div[@class = 'container']/table[@title='牌告匯率']



//html/body/div[1]/main/div[4]/table/tbody/tr[12]/td[2]
//*[@id="container"]/center/table/tbody/tr[5]/td[3]

