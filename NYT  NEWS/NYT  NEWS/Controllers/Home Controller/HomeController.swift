//
//  HomeController.swift
//  NYT  NEWS
//
//  Created by AH MARWAN  on 10/09/21.
//

import UIKit

enum ButtonSelected {
    case day
    case week
    case month
}


class HomeController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var lblSearchArticleTitle: UILabel!
    @IBOutlet weak var btnDayOutlet: UIButton!
    @IBOutlet weak var btnWeekOutlet: UIButton!
    @IBOutlet weak var btnMonthOutlet: UIButton!
    @IBOutlet weak var tableView: UITableView!
   
    
    //MARK:- Proprties / Models
    private let refreshControl = UIRefreshControl()
    let networkHandler = NetworkHandler()
    var articles: ArticleModel?
    var results: [Result] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        DispatchQueue.global(qos: .userInitiated).async {
            print("This is run on a background queue")
            
            self.callAPI(timePeriod: "1")
        }
        
            self.btnDayOutlet.backgroundColor = Config.greenColor
            self.btnDayOutlet.setTitleColor(Config.whiteColor, for: .normal)
            self.timePeriodSelected(buttonSelected: .day)
       

//        setDeafultButtons()
        setNavigationBar()
    }
    
    
    func setNavigationBar(){
        self.navigationItem.title = "NY TIMES".uppercased()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: bold(25), NSAttributedString.Key.foregroundColor: Config.blackColor ?? .black
        ]
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    
    @IBAction func onDaySelected(_ Sender: UIButton){
        timePeriodSelected(buttonSelected: .day)
        self.callAPI(timePeriod: "1")
    }
    @IBAction func onWeekSelected(_ Sender: UIButton){
        timePeriodSelected(buttonSelected: .week)
        self.callAPI(timePeriod: "7")
    }
    @IBAction func onMonthSelected(_ Sender: UIButton){
        timePeriodSelected(buttonSelected: .month)
        self.callAPI(timePeriod: "30")
    }
    
  
    
    func setDeafultButtons(){
        
        btnDayOutlet.backgroundColor = Config.lightGrayColor
        btnDayOutlet.setTitle("24H", for: .normal)
        btnDayOutlet.titleLabel?.font = medium(16)
        btnDayOutlet.setTitleColor(Config.greenColor, for: .normal)
        btnDayOutlet.layer.cornerRadius = Config.CornerRadius
        
        btnWeekOutlet.backgroundColor = Config.lightGrayColor
        btnWeekOutlet.setTitle("1W", for: .normal)
        btnWeekOutlet.titleLabel?.font = medium(16)
        btnWeekOutlet.setTitleColor(Config.greenColor, for: .normal)
        btnWeekOutlet.layer.cornerRadius = Config.CornerRadius
        
        btnMonthOutlet.backgroundColor = Config.lightGrayColor
        btnMonthOutlet.setTitle("1M", for: .normal)
        btnMonthOutlet.titleLabel?.font = medium(16)
        btnMonthOutlet.setTitleColor(Config.greenColor, for: .normal)
        btnMonthOutlet.layer.cornerRadius = Config.CornerRadius
    }
    
    
    
    func timePeriodSelected(buttonSelected: ButtonSelected ){
        self.setDeafultButtons()
        switch buttonSelected {
        case .day:
            btnDayOutlet.backgroundColor = Config.greenColor
            btnDayOutlet.setTitleColor(Config.whiteColor, for: .normal)
        case .week:
            btnWeekOutlet.backgroundColor = Config.greenColor
            btnWeekOutlet.setTitleColor(Config.whiteColor, for: .normal)
        case .month:
            btnMonthOutlet.backgroundColor = Config.greenColor
            btnMonthOutlet.setTitleColor(Config.whiteColor, for: .normal)
        }
       
    }
    
   
    
    
    
    func scrollToTop(){
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    
    
    func callAPI(timePeriod: String){
        
        // Strat animation
        
        DispatchQueue.main.async {
//            self.view.startLoading()
        }
        
        // Params
        let section = "all-sections"
        let timePeriodSelected = timePeriod
        
        networkHandler.postData(urlPath: "svc/mostpopular/v2/mostemailed/\(section)/\(timePeriodSelected).json?api-key=\(Config.APIKey)", method: .get, with: ArticleModel.self, parameters: .none) { [weak self](response) in
            
            
            // Stop animation
            DispatchQueue.global(qos: .userInitiated).async {
                print("This is run on a background queue")
                guard let self = self , let data = response else {return}
                
                // Remove all data
                self.results.removeAll()
                // Append new data
                self.results.append(contentsOf: data.results ?? [] )
                // Reload View
                self.reloadView()
                DispatchQueue.main.async {
                    print("This is run on the main queue, after the previous code in outer block")
                    
//                   self.view.stopLoading()
                     
                }
            }
            
           
            
            
        } returnError: { error in
           // self.view.stopLoading()
            // Show error message
           // self.alert(title: "Error", message: error?.localizedDescription ?? "Ops, something went wrong try again later.", preferredStyle: .alert, completion: { _ in})
        }
        
    }
    
    func reloadView(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.layoutIfNeeded()
            self.scrollToTop()
        }
    }
}





//MARK:- extension UITableViewDelegate && UITableViewDataSource
extension HomeController: UITableViewDelegate, UITableViewDataSource {
    
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleCell
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

// input string should always be in format "21/07/2016" ("dd/MM/yyyy")
/*
 Usaing
 - let day = formattedDateFromString(dateString: result.publishedDate ?? "", dateFormat: "yyyy-MM-dd", toFormat: "dd/mm/yyyy")
 - let hour = formattedDateFromString(dateString: result.updated ?? "", dateFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "HH:MM")
 */
func formattedDateFromString(dateString: String, dateFormat: String, toFormat: String) -> String? {
    
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = dateFormat
    if let date = inputFormatter.date(from: dateString) {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = toFormat
        return outputFormatter.string(from: date)
    }
    return nil
}
