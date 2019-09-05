import UIKit

protocol PhotosPresentationLogic
{
    func didGetRequest(photos: [Photo])
}

class PhotosPresenter: PhotosPresentationLogic
{
    weak var viewController: PhotosDisplayLogic?
  
    func didGetRequest(photos: [Photo]) {
        viewController?.getPhotosFromRequest(photos: photos)
    }
}
