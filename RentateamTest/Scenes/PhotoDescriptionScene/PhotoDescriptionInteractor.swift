//
//  PhotoDescriptionInteractor.swift
//  RentateamTest
//
//  Created by Виктор Григорьев on 05/09/2019.
//  Copyright (c) 2019 Виктор Григорьев. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol PhotoDescriptionBusinessLogic
{
  func doSomething(request: PhotoDescription.Something.Request)
}

protocol PhotoDescriptionDataStore
{
  //var name: String { get set }
}

class PhotoDescriptionInteractor: PhotoDescriptionBusinessLogic, PhotoDescriptionDataStore
{
  var presenter: PhotoDescriptionPresentationLogic?
  var worker: PhotoDescriptionWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: PhotoDescription.Something.Request)
  {
    worker = PhotoDescriptionWorker()
    worker?.doSomeWork()
    
    let response = PhotoDescription.Something.Response()
    presenter?.presentSomething(response: response)
  }
}