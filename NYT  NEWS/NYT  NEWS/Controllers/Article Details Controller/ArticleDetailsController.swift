//
//  ArticleDetailsController.swift
//  NYT  NEWS
//
//  Created by AH MARWAN  on 12/09/21.
//

import UIKit
import SDWebImage

class ArticleDetailsController: UITableViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var imageArticle: UIImageView!
    @IBOutlet weak var lblTitleArticle: UILabel!
    @IBOutlet weak var lblAuthorName: UILabel!
    @IBOutlet weak var lblAbstractArticle: UILabel!
    @IBOutlet weak var lblDescriptionArticle: UILabel!

    var homeController: HomeController!
    var entity: Result!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI(result: entity)
    }
    

    func setUpUI(result: Result){
        
        
        // Set imageArticle
        if !(result.media?.isEmpty ?? true) {
            if let url = URL(string: result.media?[0].mediaMetadatum?[0].url ?? "") {
                imageArticle.sd_setImage(with: url, placeholderImage: UIImage(named: "place-holder"))
            }
        }else{
            imageArticle.image = UIImage(named: "place-holder")
        }
            
        imageArticle.layer.cornerRadius = Config.CornerRadius
        imageArticle?.contentMode = .scaleAspectFit
        
        // Set Title Article
        lblTitleArticle.text = result.title ?? ""
        lblTitleArticle.numberOfLines = 0
        lblTitleArticle.textColor = Config.blackColor
        lblTitleArticle.font = medium(20)
        
        // Set Author Name
        lblAuthorName.text = result.byline ?? ""
        lblAuthorName.numberOfLines = 0
        lblAuthorName.textColor = Config.blackColor
        lblAuthorName.font = medium(16)
        
        // Set Description Foto
        lblDescriptionArticle.text = result.media?[0].caption ?? ""
        lblDescriptionArticle.textColor = Config.blackColor
        lblDescriptionArticle.font = regular(16)
        lblDescriptionArticle.numberOfLines = 0
        lblDescriptionArticle.alpha = 0.7
        
        // Set Abstract
        lblAbstractArticle.text = result.abstract ?? ""
        lblAbstractArticle.textColor = Config.blackColor
        lblAbstractArticle.font = regular(16)
        lblAbstractArticle.numberOfLines = 0
        lblAbstractArticle.alpha = 0.7
        
    }
    

}


extension ArticleDetailsController {
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
