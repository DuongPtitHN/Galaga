//
//  AppDelegate.swift
//  Test
//
//  Created by Quang Dương on 2/26/17.
//  Copyright © 2017 Quang Dương. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        var films: [[String : String]] = [
            [
                "name"  : "Logan",
                "date"   : "2016",
                "IMDB": "7.0"],
            [
                "name"  : "Fast and Furious 7",
                "date"   : "2015",
                "IMDB": "7.5"],
            [
                "name"  : "X men",
                "date"   : "2014",
                "IMDB": "6.0"],
            ]
        
        let filmToAdd  = [
            "name" : "abcx",
            "date" : "2013",
            "IMDB" : "5.5"
            ] as [String : String]
        let filmToUpdate  = [
            "name" : "fast 5",
            "date" : "2012",
            "IMDB" : "6.5"
            ] as [String : String]
        
//        var names = films.map {
//            film in
//            return films["name"]!
//        }
//        print(names)
//        
        //        for i in 0..<films.count{
        //            for (key,value) in films[i]{
        //                if value == "Logan"{
        //                    films.remove(at: i)
        //            }
        //        }
        printD(list: films)
        print("find Film by name: Logan : ")
//        findByName(list: films)
        print("add Film abcx ")
        films.append(filmToAdd)
        printD(list: films)
        print("Update:  ")
        films[1] = filmToUpdate
        printD(list: films)
        print("after delete Logan")
//        printD(list: removeByName(list: films) as! [[String : String]])
        print("abc x = Fast 1")
//        printD(list: updateNameByName(list: films) as! [[String : String]])
      
        
        //        print(sum(x: 6 ,y: 9))
        //        //closure
        //        let c = {
        //            print("hehehe")
        //        }
        //        c()
        //        let c2 : (Int) -> Int = {
        //            number in
        //            return number + 1
        //        }
        //        print(c2(9))
        //
        //
        //
        return true
    }
    func printD(list: [[String : String]]) {
        for i in 0..<list.count{
            for (key,value) in list[i]{
                print(	"\(key) : \(value)")
            }
            print("=======================")
        }
    }
    
    func printD2(list: [String : String]) {
        
        for (key,value) in list{
            print(	"\(key) : \(value)")
        }
        print("=======================")
        
    }
//    func removeByName(list: [[String : String ]]) -> Any {
//        var tempList = list
//        for i in 0..<list.count{
//            for(key,value) in list[i]{
//                if ( value == "Logan"){
//                    tempList.remove(at: i)
//                }
//            }
//            
//        }
//        return tempList
//    }
    
    
//    func updateNameByName(list: [[String : String ]]) -> Any {
//        var tempList = list
//        for i in 0..<list.count{
//            for(key,value) in list[i]{
//                if ( value == "abcx"){
//                    tempList[i].updateValue("Fast 2", forKey: key)
//                }
//            }
//            
//        }
//        return tempList
//    }
//    func findByName(list: [[String : String ]])  {
//        var tempList = list
//        for i in 0..<list.count{
//            for(key,value) in list[i]{
//                if ( value == "Logan"){
//                    printD2(list: list[i])
//                }
//            }
//            
//        }
//        
//    }
    //    func hello() -> Void {
    //        print("Hello")
    //    }
    //    func sum(x: Int, y: Int) -> Int {
    //        return x * y
    //    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

