//
//  ArticleCell.swift
//  NYT  NEWS
//
//  Created by AH MARWAN  on 10/09/21.
//

import UIKit
import SDWebImage

class ArticleCell: UITableViewCell {

    @IBOutlet weak var imageArticle: UIImageView!
    @IBOutlet weak var lblTitleArticle: UILabel!
    @IBOutlet weak var lblShareDateArticle: UILabel!
    @IBOutlet weak var lblShareHourArticle: UILabel!
    @IBOutlet weak var lblDescriptionArticle: UILabel!
    
    func setUpCell(result: Result){
        
        
        // Set imageArticle
        if !(result.media?.isEmpty ?? true) {
            if let url = URL(string: result.media?[0].mediaMetadatum?[0].url ?? "") {
                imageArticle.sd_setImage(with: url, placeholderImage: UIImage(named: "place-holder"))
            }
        }else{
            imageArticle.image = UIImage(named: "place-holder")
        }
            
        imageArticle.layer.cornerRadius = Config.CornerRadius
        imageView?.contentMode = .scaleAspectFit
        
        // Set Title Article
        lblTitleArticle.text = result.title ?? ""
        lblTitleArticle.numberOfLines = 2
        lblTitleArticle.textColor = Config.blackColor
        lblTitleArticle.font = medium(15)
        
        // Set Share Date
        let dateArticle = formattedDateFromString(dateString: result.publishedDate ?? "", dateFormat: "yyyy-MM-dd", toFormat: "dd/MM/yyyy")
        lblShareDateArticle.text = dateArticle
        lblShareDateArticle.numberOfLines = 1
        lblShareDateArticle.textColor = Config.grayColor
        lblShareDateArticle.font = regular(12)
        
        // Set Share Hour
        let hourArticle = formattedDateFromString(dateString: result.updated ?? "", dateFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "HH:MM")
        lblShareHourArticle.text = hourArticle
        lblShareHourArticle.numberOfLines = 1
        lblShareHourArticle.textColor = Config.grayColor
        lblShareHourArticle.font = regular(12)
        
        // Set Description
        lblDescriptionArticle.text = result.abstract ?? ""
        lblDescriptionArticle.textColor = Config.blackColor
        lblDescriptionArticle.font = regular(16)
        lblDescriptionArticle.numberOfLines = 0
        lblDescriptionArticle.alpha = 0.7
        
        
    }
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
