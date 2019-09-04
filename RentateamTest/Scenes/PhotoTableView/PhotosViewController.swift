import UIKit

protocol PhotosDisplayLogic: class
{
  
}

class PhotosViewController: UIViewController, PhotosDisplayLogic
{
    //MARK: Properties
    let cellIdentifier = "photoCell"
    var interactor: PhotosBusinessLogic?
    var router: (NSObjectProtocol & PhotosRoutingLogic & PhotosDataPassing)?

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
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
    
    //MARK: Outlets
    @IBOutlet weak var photosTableView: UITableView!
    
  
    // MARK: View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        photosTableView.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        photosTableView.delegate = self
        photosTableView.dataSource = self
        interactor?.makeRequest()
    }
  
    
  
    func doSomething() {
        let request = Photos.Something.Request()
        interactor?.doSomething(request: request)
    }

}

extension PhotosViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = photosTableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? PhotoTableViewCell
        cell?.phNameLabel.text = "Bruce Lee"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(integerLiteral: 100)
    }
    
}
