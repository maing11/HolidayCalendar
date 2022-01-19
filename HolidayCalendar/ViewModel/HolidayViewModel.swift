//
//  HolidayViewModel.swift
//  HolidayCalendar
//
//  Created by mai nguyen on 1/19/22.
//

import Foundation


class HolidayViewModel {
    let apiService = APIService()
    var holidayModel: HolidayModel?
    
    func getHolidayList(country:String, completion: @escaping (HolidayModel?) -> Void) {
        apiService.fetchData(client: HolidayEndpoint.holiday(country:country )) { [weak self] (holidayModel:HolidayModel?) in
            self?.holidayModel = holidayModel
            completion(self?.holidayModel)
        }
    }
    
    func listOfHoliday() -> Int {
        return holidayModel?.response.holidays.count ?? 0
    }
}
