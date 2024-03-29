//
//  ListManufacturerPresenter.swift
//  Cartalogue
//
//  Created by Caio de Souza on 24/04/2018.
//  Copyright (c) 2018 Caio de Souza. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

protocol ListManufacturerPresentationLogic{
  func presentFetchManufacturers(response: ListManufacturers.FetchManufacturers.Response)
  func presentErrorAlert(title: String?, message: String?)
  func endRefreshControlIfNeeded()
  func presentSelectManufacturer()
}

class ListManufacturerPresenter: ListManufacturerPresentationLogic {
 
  weak var viewController: ListManufacturerDisplayLogic?
  
  // MARK: Do FetchManufacturers
  
  func presentFetchManufacturers(response: ListManufacturers.FetchManufacturers.Response)
  {
    var displayedManufacturers: [ListManufacturers.FetchManufacturers.ViewModel.DisplayedManufacturer] = []
    
    _ = response.manufacturer.wkdaArray.forEach { (wkda) in
        let id = wkda.id
        let name = wkda.name
        let displayedManufacturer = ListManufacturers.FetchManufacturers.ViewModel.DisplayedManufacturer(id: id, name: name)
        displayedManufacturers.append(displayedManufacturer)
        
    }
    let totalPageCount = response.manufacturer.totalPageCount
    
    let viewModel = ListManufacturers.FetchManufacturers.ViewModel(totalPageCount: totalPageCount,
                                                                   displayedManufacturers: displayedManufacturers)
    viewController?.displayFetchManufacturers(viewModel: viewModel)
    viewController?.updateCurrentPageLabel(viewModel: viewModel)
  }
    
  // MARK: Present Error Alert
  func presentErrorAlert(title: String?, message: String?){
    viewController?.presentAlert(title: title, message: message)
  }
    
  func endRefreshControlIfNeeded(){
    viewController?.endRefreshControlIfNeeded()
  }
  
  func presentSelectManufacturer() {
    viewController?.selectManufacturer()
  }
}
