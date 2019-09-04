import UIKit
import Alamofire
import SwiftyJSON

protocol PhotosBusinessLogic
{
    func doSomething(request: Photos.Something.Request)
    func makeRequest()
}

protocol PhotosDataStore
{
  //var name: String { get set }
}

class PhotosInteractor: PhotosBusinessLogic, PhotosDataStore
{
    private let headers: HTTPHeaders = ["Authorization": "563492ad6f917000010000014926874ef5ab4f26bcb8591f7b00b5e5"]
    private let url = URL(string: "https://api.pexels.com/v1/curated?per_page=15&page=1")

    var presenter: PhotosPresentationLogic?
    var worker: PhotosWorker?
    var photos: [Photo] = []
    
  //var name: String = ""
  
  // MARK: Do something
  
    func doSomething(request: Photos.Something.Request) {
        worker = PhotosWorker()
        worker?.doSomeWork()

        let response = Photos.Something.Response()
        presenter?.presentSomething(response: response)
    }
    
    func makeRequest() {
        guard let url = url else { return }
        AF.request(url, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.data {
                    do{
                        let data = try JSON(data: json)
                        for photoJson in data["photos"].arrayValue {
                            if let photo = Photo(json: photoJson) {
                                print("\(photo.phName)")
                                self.photos.append(photo)
                            }
                        }
                    }
                    catch{
                        print("JSON Error")
                    }
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
}
