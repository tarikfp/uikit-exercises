//
//  ViewController.swift
//  EasyBrowser
//
//  Created by Tarık Fatih PINARCI on 8.05.2023.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate, UITableViewDelegate, UITableViewDataSource {
  var webView: WKWebView!
  var progressView: UIProgressView!
  let websites = ["hackingwithswift.com", "apple.com"]

  let tableView: UITableView = {
    let table = UITableView()
    table.register(UITableViewCell.self, forCellReuseIdentifier: "websiteCell")
    return table
  }()
  

  override func viewDidLoad() {
    super.viewDidLoad()

    initializeWebView()

    setupTableView()
    view.tag = 0

    setCurrentView(viewToSet: tableView)
  }

  func setCurrentView (viewToSet: UIView) {
    view = viewToSet
  }

  func initializeWebView(){
    webView = WKWebView()
    webView.navigationDelegate = self
    webView.allowsBackForwardNavigationGestures = true
  }

  func setupTableView(){
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "websiteRow")
    view.addSubview(tableView)
    title = "Available websites"
  }

  func setupWebView(){

    setupUIBar()
    setCurrentView(viewToSet: webView)
    view.tag = 1
    webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil )

  }





  func setupUIBar(){
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .done, target: self, action: #selector(onOpenPress))
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(closeWebView))


    progressView = UIProgressView(progressViewStyle: .default)

    let spacer = UIBarButtonItem(systemItem: .flexibleSpace)
    let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
    let goBack = UIBarButtonItem(barButtonSystemItem: .rewind, target: webView, action: #selector(webView.goBack))
    let goForward = UIBarButtonItem(barButtonSystemItem: .fastForward, target: webView, action: #selector(webView.goForward))
    let progress = UIBarButtonItem(customView: progressView)

    toolbarItems = [progress, spacer, goBack, goForward, refresh]
    navigationController?.isToolbarHidden = false

  }

  @objc func closeWebView(){
    navigationItem.setLeftBarButton(nil, animated: true)
    navigationItem.setRightBarButton(nil, animated: true)
    navigationController?.isToolbarHidden = true
    title = "Available websites"
    view = tableView
  }
  

  @objc func onOpenPress(){
    let alertVC = UIAlertController(title: "Open", message: nil, preferredStyle: .actionSheet)

    for website in websites {
      alertVC.addAction(UIAlertAction(title: website, style: .default,handler: onOpenPage))
    }

    alertVC.addAction(UIAlertAction(title: "Cancel", style: .default))

    present(alertVC, animated: true)
    
  }

  func onOpenPage(action:UIAlertAction){
    guard let actionTitle = action.title else { return }

    let url = getSafeURLFromString(websiteUrlString: "https://" + actionTitle)

    if let safeUrl = url{
      webView.load(URLRequest(url: safeUrl))

    }

  }

  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    if view.tag == 1 {
      title = webView.title
    }
  }

  func getSafeURLFromString(websiteUrlString:String) -> URL? {
    let url = URL(string: websiteUrlString)
    guard let safeWebsiteUrl = url else {
      let alertVC = UIAlertController(title: "Warning", message: "Invalid Url", preferredStyle: .alert)
      alertVC.addAction(.init(title: "Ok", style: .default))
      present(alertVC, animated: true)
      return nil
    }
    return safeWebsiteUrl

  }


  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == "estimatedProgress"{
      progressView.progress = Float(webView.estimatedProgress)
    }
  }


  func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    let url = navigationAction.request.url


    if let host = url?.host {
      for website in websites{
        print( "host:\(host), website:\(website)")
        if host.contains(website){
          decisionHandler(.allow)
          return
        }
      }
    }

    let alertVC = UIAlertController(title: "Warning", message: ((url?.host) != nil) ?  "This website(\(url!.host!)) is not allowed":"This website is not allowed", preferredStyle: .alert)

    alertVC.addAction(UIAlertAction(title: "Ok",style: .default))

    present(alertVC, animated: true)

    decisionHandler(.cancel)
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "websiteRow", for: indexPath)
    var content = cell.defaultContentConfiguration()
    content.text = websites[indexPath.row]
    cell.contentConfiguration = content
    return cell
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return websites.count
  }





  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    setupWebView()

    let selectedWebsite = websites[indexPath.row]

    if let safeUrl = getSafeURLFromString(websiteUrlString: "https://" + selectedWebsite){

      webView.load(URLRequest(url: safeUrl))
    }
  }


}

