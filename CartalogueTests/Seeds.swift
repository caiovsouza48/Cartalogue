//
//  Seeds.swift
//  CartalogueTests
//
//  Created by Caio de Souza on 29/04/2018.
//  Copyright © 2018 Caio de Souza. All rights reserved.
//
@testable import Cartalogue
struct Seeds {
    struct SeededListManufacturerParameters {
        static let page0Size15Parameter = ListManufacturers.ListManufacturerParameters(page: 0, pageSize: 15)
    }
    
    struct SeededMainTypesParameters {
        static let page0Size15ID020Parameter = MainTypes.MainTypesParameters(page: 0, pageSize: 15, manufacturerID: "020")
    }
    
    struct SeededWkda {
        static let page0WkdaArrayOfPageSize15 = [Wkda(id: "0", name: "Agrale"),
                                       Wkda(id: "1", name: "Bransinca"),
                                       Wkda(id: "2", name: "Comil"),
                                       Wkda(id: "101", name: "Marcopolo"),
                                       Wkda(id: "102", name: "Mascarello"),
                                       Wkda(id: "120", name: "Puma"),
                                       Wkda(id: "124", name: "TAC"),
                                       Wkda(id: "125", name: "Troller"),
                                       Wkda(id: "126", name: "Romi"),
                                       Wkda(id: "5", name: "Neobus"),
                                       Wkda(id: "200", name: "Apollo"),
                                       Wkda(id: "201", name: "Audi"),
                                       Wkda(id: "540", name: "BMW"),
                                       Wkda(id: "546", name: "Mercedes-Benz"),
                                       Wkda(id: "547", name: "Opel")]
    }
    struct API{
        static let page0APIManufacturer = APIManufacturer(page: 0, pageSize: 15, totalPageCount: 2, wkda: Seeds.SeededWkda.page0WkdaArrayOfPageSize15)
    }
}


extension APIManufacturer{
    init(page: Int, pageSize: Int, totalPageCount: Int, wkda: [Wkda]){
        self.init()
        self.page = page
        self.pageSize = pageSize
        self.totalPageCount = totalPageCount
        self.wkdaArray = wkda
    }
}
