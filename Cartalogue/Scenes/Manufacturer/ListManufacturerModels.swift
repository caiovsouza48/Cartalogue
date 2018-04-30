//
//  ListManufacturerModels.swift
//  Cartalogue
//
//  Created by Caio de Souza on 24/04/2018.
//  Copyright (c) 2018 Caio de Souza. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//
enum ListManufacturers{
  struct ListManufacturerParameters{
    var page: Int
    var pageSize: Int
  }
 
  // MARK: Use cases
  enum FetchManufacturers{
    
    struct Request{
        var parameters: ListManufacturerParameters
        
    }
    struct Response{
        var manufacturer : APIManufacturer
    }
    struct ViewModel{
        var totalPageCount: Int
        struct DisplayedManufacturer{
            var id: String
            var name: String
        }
        var displayedManufacturers : [DisplayedManufacturer]
    }
  }
    
  enum SelectManufacturer{
    struct Selected{
      var wkda : Wkda
    }
  }
}