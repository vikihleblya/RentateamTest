import UIKit
import SDWebImage

protocol PhotosDisplayLogic: class
{
    func getPhotosFromRequest(photos: [Photo])
}

class PhotosViewController: UIViewController, PhotosDisplayLogic
{
    //MARK: Properties
    private let cellIdentifier = "photoCell"
    private var photos: [Photo] = []
    private var fetchingMore = false
    var interactor: PhotosBusinessLogic?
    var router: (NSObjectProtocol & PhotosDataPassing)?

    // MARK: Object lifecycle

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

    // MARK: Setup
  
  private func setup() {
    let viewController = self
    let interactor = PhotosInteractor()
    let presenter = PhotosPresenter()
    let router = PhotosRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
    
    //MARK: Outlets
    @IBOutlet weak var photosTableView: UITableView!
    
  
    // MARK: View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        interactor?.makeRequest(photosCount: photos.count)
    }
    
    func setupTableView() {
        photosTableView.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        photosTableView.delegate = self
        photosTableView.dataSource = self
    }
  
    func getPhotosFromRequest(photos: [Photo]) {
        self.photos += photos
        self.photosTableView.reloadData()
        fetchingMore = false
    }
    
    func fetch() {
        fetchingMore = true
        print("fetch")
        print("AF | VC | photo count to fetch: \(photos.count)")
        interactor?.makeRequest(photosCount: photos.count)
    }

}

extension PhotosViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = photosTableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! PhotoTableViewCell
        if !photos.isEmpty {
            let photo = photos[indexPath.row]
            cell.phNameLabel.text = photo.phName
            
            cell.photoImageView?.sd_setImage(with: photo.photoUrl, completed: nil)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(integerLiteral: 100)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !fetchingMore {
                fetch()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        router?.routeTo(from: storyboard, routeStoryBoardId: "photoDescription", navigationController: navigationController, photo: photo)
    }
    
}
