import UIKit

protocol PhotosPresentationLogic
{
    func presentSomething(response: Photos.Something.Response)
    func didGetRequest(photos: [Photo])
}

class PhotosPresenter: PhotosPresentationLogic
{
  weak var viewController: PhotosDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: Photos.Something.Response)
  {
    let viewModel = Photos.Something.ViewModel()
  }
    func didGetRequest(photos: [Photo]) {
        viewController?.getPhotosFromRequest(photos: photos)
    }
}
