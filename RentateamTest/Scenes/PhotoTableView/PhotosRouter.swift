//
//  PhotosRouter.swift
//  RentateamTest
//
//  Created by Виктор Григорьев on 04/09/2019.
//  Copyright (c) 2019 Виктор Григорьев. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol PhotosRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol PhotosDataPassing
{
  var dataStore: PhotosDataStore? { get }
}

class PhotosRouter: NSObject, PhotosRoutingLogic, PhotosDataPassing
{
  weak var viewController: PhotosViewController?
  var dataStore: PhotosDataStore?
  
  // MARK: Routing
  
  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}

  // MARK: Navigation
  
  //func navigateToSomewhere(source: PhotosViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: PhotosDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
