//
//  MainTypesRouter.swift
//  Cartalogue
//
//  Created by Caio de Souza on 27/04/2018.
//  Copyright (c) 2018 Caio de Souza. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol MainTypesRoutingLogic{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol MainTypesDataPassing{
  var dataStore: MainTypesDataStore? { get }
}

class MainTypesRouter: NSObject, MainTypesRoutingLogic, MainTypesDataPassing{
  weak var viewController: MainTypesViewController?
  var dataStore: MainTypesDataStore?
  
}