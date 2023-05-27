//
//  ViewController.swift
//  LocalNotifications
//
//  Created by Tarık Fatih PINARCI on 27.05.2023.
//

import UserNotifications
import UIKit

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white

    navigationItem.leftBarButtonItem = .init(title: "Register", style: .plain, target: self, action: #selector(registerLocal))

    navigationItem.rightBarButtonItem = .init(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
  }

  @objc func registerLocal() {
    let center = UNUserNotificationCenter.current()

    center.requestAuthorization(options : [.alert, .badge, .sound]) {
      isGranted, error in

      if isGranted {
        print("Granted")
      } else {
        print("Not granted")
      }

    }
  }

  @objc func scheduleLocal() {
    registerCategories()

    let center = UNUserNotificationCenter.current()

    let content = UNMutableNotificationContent()
    content.title = "Late wake up call"
    content.body = "Hey there! You better wake up before its too late to start to a new day!"
    content.categoryIdentifier = "alarm"
    content.userInfo = ["userId": 2]
    content.sound = .default

    var dateComponents = DateComponents()
    dateComponents.hour = 10
    dateComponents.minute = 30
    //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

    center.add(request)

  }


  func registerCategories() {
    let center = UNUserNotificationCenter.current()
    center.delegate = self

    let show = UNNotificationAction(identifier: "show", title: "Tell me more", options: .foreground)
    let category = UNNotificationCategory(identifier: "alarm", actions: [show], intentIdentifiers: [])

    center.setNotificationCategories([category])
  }

  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo

    if let customData = userInfo["userId"] as? Int{
      print("userId received: \(customData)")

      switch response.actionIdentifier {
      case UNNotificationDefaultActionIdentifier:
        print("Default identifier")

      case "show":
        print("Show more information")

      default:
        break

      }
    }

    completionHandler()
  }

}

