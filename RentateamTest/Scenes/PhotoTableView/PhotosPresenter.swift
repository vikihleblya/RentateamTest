import UIKit

protocol PhotosPresentationLogic
{
  func presentSomething(response: Photos.Something.Response)
}

class PhotosPresenter: PhotosPresentationLogic
{
  weak var viewController: PhotosDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: Photos.Something.Response)
  {
    let viewModel = Photos.Something.ViewModel()
  }
}
