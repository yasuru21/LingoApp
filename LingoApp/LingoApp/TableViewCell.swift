//
//  TableViewCell.swift
//  LingoApp
//
//  Created by McLoud, Ian on 4/27/21.
/*
 Michael Quinn - michquin@iu.edu
 Ian McLoud - imcloud@iu.edu
 Yash Asuru - yasuru@iu.edu
 */
//

import UIKit

class TableViewCell: UITableViewCell {

    //all connections for the table vc
    @IBOutlet weak var wordTableLabel: UILabel!
    @IBOutlet weak var speechTableLabel: UILabel!
    @IBOutlet weak var defTableLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
