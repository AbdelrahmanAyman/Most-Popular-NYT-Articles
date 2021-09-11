//
//  ArticleCell.swift
//  NYT  NEWS
//
//  Created by AH MARWAN  on 10/09/21.
//

import UIKit

class ArticleCell: UITableViewCell {

    @IBOutlet weak var imageArticle: UIImageView!
    @IBOutlet weak var lblTitleArticle: UILabel!
    @IBOutlet weak var lblShareDateArticle: UILabel!
    @IBOutlet weak var lblShareHourArticle: UILabel!
    @IBOutlet weak var lblDescriptionArticle: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
