//
//  AppDelegate.swift
//  ExcelMock
//
//  Created by Matt Gioe on 9/14/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import UIKit
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

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
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
            do {
                let contents = try String(contentsOf: url)
                
            
                let rootViewController = window?.rootViewController as! TableSheetsViewController
                rootViewController.dataTable  = DataModel.init(commaSeparatedData: contents.components(separatedBy: ","))
                
            } catch {
                //send xlsx to API for parsing
                print("We've found an xlsx")
                do {
                    
        
                    Alamofire.upload(
                        multipartFormData: { multipartFormData in
                            multipartFormData.append(url, withName: "excel")
                    },
                        to: "https://excelcsv.herokuapp.com/upload",
                        encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload.responseString { response in
                                    debugPrint(response.description)
                                    let parsedResponse = response.description.replacingOccurrences(of: "SUCCESS: \n", with: "")
                                    let rootViewController = self.window?.rootViewController as! UINavigationController
                                    let visibleViewController = rootViewController.visibleViewController as! TableSheetsViewController
                                    visibleViewController.dataTable  = DataModel.init(commaSeparatedData: parsedResponse.components(separatedBy: ","))

                                }
                            case .failure(let encodingError):
                                print(encodingError)
                            }
                    }
                    )
                    
                    
                } catch {
                    print("Couldn't parse the xlsx")

                }
            }

        return true
    }


}

