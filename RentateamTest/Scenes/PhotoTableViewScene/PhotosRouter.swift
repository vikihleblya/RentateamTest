import UIKit

protocol PhotosDataPassing
{
    var dataStore: PhotosDataStore? { get }
    func routeTo(from storyboard: UIStoryboard?, routeStoryBoardId: String, navigationController: UINavigationController?, photo: Photo)
}

class PhotosRouter: NSObject, PhotosRoutingLogic, PhotosDataPassing
{
    weak var viewController: PhotosViewController?
    var dataStore: PhotosDataStore?
    
    func routeTo(from storyboard: UIStoryboard?, routeStoryBoardId: String, navigationController: UINavigationController?, photo: Photo) {
        if let routeViewController = storyboard?.instantiateViewController(withIdentifier: routeStoryBoardId) as? PhotosDescriptionViewController {
            routeViewController.photo = photo
            navigationController?.pushViewController(routeViewController, animated: true)
        }
    }
}
