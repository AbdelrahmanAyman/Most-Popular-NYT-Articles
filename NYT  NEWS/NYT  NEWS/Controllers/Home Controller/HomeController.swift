//
//  HomeController.swift
//  NYT  NEWS
//
//  Created by AH MARWAN  on 10/09/21.
//

import UIKit

class HomeController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var lblSearchArticleTitle: UILabel!
    @IBOutlet weak var btnDayOutlet: UIButton!
    @IBOutlet weak var btnWeekOutlet: UIButton!
    @IBOutlet weak var btnMonthOutlet: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Proprties / Models
    let networkHandler = NetworkHandler()
    var articles = [ArticleModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        tableView.delegate = self
        tableView.dataSource = self
        
        callAPI()
    }
    
    
    func callAPI(){
        
        // Strat animation
        DispatchQueue.main.async {
         //   self.view.startLoading()
        }
        
        // call API
       
        let section = "all-sections"
        let timePeriod = "1"
        
        networkHandler.postData(urlPath: "svc/mostpopular/v2/mostemailed/\(section)/\(timePeriod).json?api-key=\(Config.APIKey)", method: .get, with: ArticleModel.self, parameters: .none) { [weak self](response) in
            
            // Stop animation
            DispatchQueue.main.async {
              //  self?.view.stopLoading()
            }
            
            guard let self = self , let data = response else {return}
            
            // Remove all data
            self.articles.removeAll()
            // Append new data
            self.articles.append(contentsOf: [data] )
            // Reload View
            //self.reloadTableView()
            print(data.results, "Data!!")
        } returnError: { error in
           // self.view.stopLoading()
            // Show error message
           // self.alert(title: "Error", message: error?.localizedDescription ?? "Ops, something went wrong try again later.", preferredStyle: .alert, completion: { _ in})
        }
        
    }
    
    


}



//MARK:- extension UITableViewDelegate && UITableViewDataSource
extension HomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! ArticleCell
        cell.setUpCell(result: results[indexPath.row])
        return cell
    }
    
    // heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
        /*
        // Show Popup ArtistDetailController
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "artistDetailController") as! ArtistDetailController
        popOverVC.entity = results[indexPath.row]
        self.present(popOverVC, animated: true)*/
    }
}
