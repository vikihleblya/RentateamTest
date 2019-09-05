import UIKit

protocol PhotoDescriptionDisplayLogic: class
{
  func displaySomething(viewModel: PhotoDescription.Something.ViewModel)
}

class PhotoDescriptionViewController: UIViewController, PhotoDescriptionDisplayLogic
{
  var interactor: PhotoDescriptionBusinessLogic?
  var router: (NSObjectProtocol & PhotoDescriptionRoutingLogic & PhotoDescriptionDataPassing)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
    //MARK: Outlets
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var phNameLabel: UILabel!
    @IBOutlet weak var photoUrlLabel: UILabel!
    @IBOutlet weak var dateOfCaching: UILabel!
    
  
    // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = PhotoDescriptionInteractor()
    let presenter = PhotoDescriptionPresenter()
    let router = PhotoDescriptionRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    doSomething()
  }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
  
  func doSomething()
  {
    let request = PhotoDescription.Something.Request()
    interactor?.doSomething(request: request)
  }
  
  func displaySomething(viewModel: PhotoDescription.Something.ViewModel)
  {
    //nameTextField.text = viewModel.name
  }
}
