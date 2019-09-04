import UIKit

protocol PhotosBusinessLogic
{
  func doSomething(request: Photos.Something.Request)
}

protocol PhotosDataStore
{
  //var name: String { get set }
}

class PhotosInteractor: PhotosBusinessLogic, PhotosDataStore
{
  var presenter: PhotosPresentationLogic?
  var worker: PhotosWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: Photos.Something.Request)
  {
    worker = PhotosWorker()
    worker?.doSomeWork()
    
    let response = Photos.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
