//
//  SearchVC.swift
//  DalmiaBestPrice
//
//  Created by dalmia on 27/06/19.
//  Copyright © 2019 dalmia. All rights reserved.
//

import UIKit

class SearchVC: UIViewController,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource {
  
  
   
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    var searchActive : Bool = false
    
      //var recentArray = NSArray()
    var recentArray: [AnyObject?] = []

      var popularData = ["MEN WATCH","WOMEN FASHION TOP AND JEANS","FITNESS","ELECTRONICS"]
   // let data = [["0,0", "0,1", "0,2"], ["1,0", "1,1", "1,2"]]

    let headerTitles = ["RECENT SEARCHES","POPULAR SEARCHES"]
    var filtered:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.tableView.registerCell(ofType: SearchTableCell.self)
        self.tableView.register(UINib(nibName: "SearchTableCell", bundle: nil), forCellReuseIdentifier: "SearchTableCell")

          searchBar.delegate = self
//        topBar = (JKTopBar(controller: self, withTitle: "Search", withImage: "left-arrow.png") as JKTopBar)
//        topBar.delegate=self
      //  self.view.addSubview(topBar.view);
        
        
        // Do any additional setup after loading the view.
      //  recentArray = ["horse", "cow", "camel", "sheep", "goat"]
        
        let defaults = UserDefaults.standard
        recentArray = defaults.stringArray(forKey: "RecentArray") as [AnyObject?]? ?? [String]() as [AnyObject?]
      
    }
    
    
     func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
     func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
     func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchActive = false;
    }
    
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
 //   recentArray.append(searchBar.text! as AnyObject)
    recentArray.insert(searchBar.text! as AnyObject , at: 0)

    let defaults = UserDefaults.standard
    defaults.set(recentArray, forKey: "RecentArray")
         searchBar.resignFirstResponder()
         searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
  
        
        filtered = recentArray.filter({ (text) -> Bool in let tmp: NSString = text as! NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        }) as! [String]
        
        print(filtered.count)
            print(searchText)
//        if(filtered.count == 0){
//            self.tableView.isHidden = true
//
//            searchActive = false;
//        } else {
//               self.tableView.isHidden = false
//            searchActive = true;
//        }
        
        if searchText.isEmpty == true{
            self.tableView.isHidden = false
            searchActive = false
        }
        self.tableView.reloadData()
    }
    
   
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
 
            return headerTitles[section]
 
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
//     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data[section].count
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
        
        if(searchActive) {
            return filtered.count
        }
        return recentArray.count;
            
        }else{
            return popularData.count;
        }
    }
    
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell : SearchTableCell = tableView.dequeueReusableCell(withIdentifier: "SearchTableCell", for: indexPath) as! SearchTableCell
        if(searchActive && filtered.count>0){
            cell.lblSearch.text = filtered[indexPath.row]
        } else {
            cell.lblSearch.text = recentArray[indexPath.row] as? String
        }
            
             cell.btnDelete.addTarget(self, action: #selector(onClickedDelete(_:)), for: .touchUpInside)
            cell.btnDelete.tag = indexPath.row
        cell.btnDelete.isHidden = false
        return cell;
        }else{
     let cell : SearchTableCell = tableView.dequeueReusableCell(withIdentifier: "SearchTableCell", for: indexPath) as! SearchTableCell
                cell.lblSearch.text = popularData[indexPath.row];
           cell.btnDelete.isHidden = true
            
            return cell;
        }
    }
    
     @objc func onClickedDelete(_ sender: UIButton) {
         recentArray.remove(at: sender.tag)
        let defaults = UserDefaults.standard
        defaults.set(recentArray, forKey: "RecentArray")
        
         self.tableView.reloadData()
    }
    @IBAction func onClickBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true
        )
    }
    
   

    
    
}
