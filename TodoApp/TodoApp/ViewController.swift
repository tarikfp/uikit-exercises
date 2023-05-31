//
//  ViewController.swift
//  TodoApp
//
//  Created by Tarık Fatih PINARCI on 31.05.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  var todoItems: [String] = ["My first todo item"]
  var tableView: UITableView!
  let tableViewReuseIdentifier = "TodoItem"

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Todo items"
    navigationController?.navigationBar.prefersLargeTitles = true


    tableView = {
      let tableView = UITableView()
      tableView.delegate = self
      tableView.dataSource = self
      tableView.allowsSelectionDuringEditing = false
      tableView.frame = view.bounds
      tableView.translatesAutoresizingMaskIntoConstraints = false
      tableView.largeContentTitle = "Todo list"
      tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: tableViewReuseIdentifier)
      return tableView
    }()
    

    view.addSubview(tableView)

    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTodoItem))
  }

  @objc func addTodoItem(){
    let alertVC = UIAlertController(title: "Add todo item", message: "", preferredStyle: .alert)

    alertVC.addTextField()

    alertVC.addAction(UIAlertAction(title: "Save", style: .default){
      [weak self] action in
      if let textInputValue = alertVC.textFields?[0].text {
        if textInputValue == ""{
          action.isEnabled = false
          return
        }
        self?.todoItems.append(textInputValue)
        if let todoItemsCount = self?.todoItems.count{
          self?.tableView.insertRows(at: [IndexPath(row: todoItemsCount - 1 , section: 0)], with: .automatic)
        }

      }
    })

    alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    

    present(alertVC, animated: true)

  }

  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }


  func removeTodoItem(todoItemValue: String){
    todoItems = todoItems.filter{$0 != todoItemValue }
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return todoItems.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: tableViewReuseIdentifier, for: indexPath)
    var defaultContent = cell.defaultContentConfiguration()
    defaultContent.text = todoItems[indexPath.row]
    cell.contentConfiguration = defaultContent
    return cell
  }

  


  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

    let removeAction = UIContextualAction(style: .destructive, title: "Remove") {
      [weak self] (action, view, completionHandler) in

      if let safeTodoItems = self?.todoItems {
        self?.removeTodoItem(todoItemValue: safeTodoItems[indexPath.row])

        self?.tableView.deleteRows(at: [indexPath], with: .automatic)
      }

      completionHandler(true)
    }

    let editAction = UIContextualAction(style: .destructive, title: "Edit") {
      [weak self] (action, view, completionHandler) in

      if let safeTodoItems = self?.todoItems {
        let alertVC = UIAlertController(title: "Edit", message: "", preferredStyle: .alert)

        alertVC.addTextField()

        alertVC.addAction(UIAlertAction(title: "Edit", style: .default){
         [weak self] _ in
          if let textInputValue = alertVC.textFields?[0].text{
            self?.todoItems[indexPath.row] = textInputValue
            self?.tableView.reloadData()
          }
        })

        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        self?.present(alertVC, animated: true)
      }
      completionHandler(true)
    }

    removeAction.backgroundColor = .systemRed
    editAction.backgroundColor = .systemOrange

    
    let swipeActionsConfiguration = UISwipeActionsConfiguration(actions: [editAction, removeAction])
    swipeActionsConfiguration.performsFirstActionWithFullSwipe = false
    return swipeActionsConfiguration

  }
}



class CustomTableViewCell: UITableViewCell {
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.selectionStyle = .none
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
