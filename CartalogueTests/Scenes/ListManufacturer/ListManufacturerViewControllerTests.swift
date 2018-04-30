//
//  ListManufacturerViewControllerTests.swift
//  Cartalogue
//
//  Created by Caio de Souza on 28/04/2018.
//  Copyright (c) 2018 Caio de Souza. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import Cartalogue
import XCTest

class ListManufacturerViewControllerTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: ListManufacturerViewController!
  var window: UIWindow!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    window = UIWindow()
    setupListManufacturerViewController()
  }
  
  override func tearDown()
  {
    window = nil
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupListManufacturerViewController()
  {
    let bundle = Bundle.main
    let storyboard = UIStoryboard(name: "Main", bundle: bundle)
    sut = storyboard.instantiateViewController(withIdentifier: "ListManufacturers") as! ListManufacturerViewController
  }
  
  func loadView()
  {
    window.addSubview(sut.view)
    RunLoop.current.run(until: Date())
  }
  
  // MARK: Test doubles
  
  class ListManufacturerBusinessLogicSpy: ListManufacturerBusinessLogic{
    
    // MARK: Method call expectations
    var doFetchManufacturersCalled = false
    var isLastPageCalled = false
    var selectManufacturerCalled = false
    
    func doFetchManufacturers(request: ListManufacturers.FetchManufacturers.Request) {
        doFetchManufacturersCalled = true
    }
    
    func isLastPage(page: Int) -> Bool {
        isLastPageCalled = true
        return true
    }
    
    func selectManufacturer(request: ListManufacturers.SelectManufacturer.Selected) {
        selectManufacturerCalled = true
    }
    
  }

    
  class TableViewSpy: UITableView{
    // MARK: Method call expectations
    var reloadDataCalled = false
    
    // MARK: Spied methods
    
    override func reloadData(){
        reloadDataCalled = true
    }
}
  
  // MARK: Tests
  
  func testShouldDoFetchManufacturersgWhenViewIsLoaded(){
    // Given
    let spy = ListManufacturerBusinessLogicSpy()
    sut.interactor = spy
    loadView()
    
    // When
    sut.viewDidLoad()
    
    // Then
    XCTAssertTrue(spy.doFetchManufacturersCalled, "viewDidLoad() should ask the interactor to do fetch the manufacturers")
  }
  
  func testDisplayFetchedManufacturers(){
    // Given
    let tableViewSpy = TableViewSpy()
    sut.tableView = tableViewSpy
    
    // When
    let displayedManufacturers = [ListManufacturers.FetchManufacturers.ViewModel.DisplayedManufacturer(id: "0", name: "Test1"),
                                  ListManufacturers.FetchManufacturers.ViewModel.DisplayedManufacturer(id: "1", name: "Test2")]
    let viewModel = ListManufacturers.FetchManufacturers.ViewModel(totalPageCount: 1, displayedManufacturers: displayedManufacturers)
    sut.displayFetchManufacturers(viewModel: viewModel)
    
    // Then
     XCTAssertTrue(tableViewSpy.reloadDataCalled, "Displaying fetched Manufacturers should reload the table view")
  }
  
    func testNumberOfSectionEqualToCurrentPage(){
        // Given
        let tableViewSpy = TableViewSpy()
        sut.tableView = tableViewSpy
        let tableView = sut.tableView
        sut.currentPage = 1
        
        // When
        let numberOfSections = sut.numberOfSections(in: tableView!)
        
        // Then
        XCTAssertEqual(numberOfSections, sut.currentPage+1, "A properly configured table view Number of Sections should display the Number Of Section equal to the Current Page")
    }
    
    func testShouldReloadTableViewWhenRefreshControlIsActive(){
        // Given
        let spy = ListManufacturerBusinessLogicSpy()
        sut.interactor = spy
        sut.currentPage = 1
        loadView()
        
        // When
        sut.refreshControlTriggered(sender: sut.refreshControl)
        
        // Then
        XCTAssertEqual(sut.currentPage,0 , "Refresh Control should Set the Current Page to 0")
        XCTAssertTrue(spy.doFetchManufacturersCalled, "doFetchManufacturers(request:) should be Called when refreshControl is Triggered")
    }
}