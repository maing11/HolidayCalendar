//
//  HolidayTableViewCell.swift
//  HolidayCalendar
//
//  Created by mai nguyen on 1/18/22.
//

import UIKit


class HolidayTableViewCell: UITableViewCell {

    static let identifier = "HolidayTableViewCell"
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func updateLabel(holidayDetail: HolidayDetail?) {
        nameLabel.text = holidayDetail?.name
        dateLabel.text = convertDateFormater(holidayDetail?.date.iso)
    }
    
    
    func convertDateFormater(_ date: String?) -> String {
        var fixDate = ""

      let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyy-MM-dd"

        if let originalDate = date {
            if let newDate = dateFormater.date(from: originalDate){
                dateFormater.dateFormat = "MMMM dd, yyyy"
                fixDate = dateFormater.string(from: newDate)
            }
        }
        return fixDate
    }
}
