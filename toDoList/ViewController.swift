
import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {
    
    var todoItems = Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory:Category?{
        didSet{
          loadItems()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadItems()
        
    }
    // Bölümdeki satır sayısını ayarlamayı sağlar.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    // Tablo görünümünün belirli bir konuma bir hücre eklenmesini ister.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Daha önceden oluşturulmuş satır varsa bunun tekrar kullanılmasını sağlar.
        // Kullanıcı yukarı aşağı giderken her satır için hücre oluşturulması gerekmez.
        let cell = tableView.dequeueReusableCell(withIdentifier:"ToDoItemCell",for: indexPath)
        
        if let item = itemArray[indexPath.row]{
            
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.done ? .checkmark: .none
        }else{
                cell.textLabel?.text = "No Items Added  "
            }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
        //Seçimi kaldırma işleminin canlandırması ve seçimi kaldırmagörevi
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new Diary Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) {(action) in
// Kullanıcı IAction'ımıza öğe eklemek için tıkladığında ne olacak?
            if let currentCategory = self.selectedCategory{
                do{
                    try self.realm.write{
                        let newItem = Item()
                        newItem.title = textField.text!
                        currentCategory.items.append(newItem)
                    }
                }catch{
                    print("Error Saving New Items\(error)")
                }
            }
            self.tableView.reloadData()
        }
        alert.addTextField{(alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true,completion: nil)
    }
    func saveItems(){
        do{
            try context.save()
        }catch{
            print("Erorr saving context\(error)")
        }
        self.tableView.reloadData()
    }
    func loadItems() {
  self.tableView.reloadData()
    }
}
//extension ToDoListViewController: UISearchBarDelegate{
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request:NSFetchRequest<Item> = Item.fetchRequest()
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//        loadItems(with: request,predicate: predicate    )
//        
//    }
//}
