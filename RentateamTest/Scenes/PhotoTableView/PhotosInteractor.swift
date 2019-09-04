import UIKit
import Alamofire
import SwiftyJSON

protocol PhotosBusinessLogic
{
    func makeRequest()
    func parseJson(response: DataResponse<Any>)
}

protocol PhotosDataStore {
    
}

class PhotosInteractor: PhotosBusinessLogic, PhotosDataStore {
    
    private let headers: HTTPHeaders = ["Authorization": "563492ad6f917000010000014926874ef5ab4f26bcb8591f7b00b5e5"]
    private let url = URL(string: "https://api.pexels.com/v1/curated?per_page=15&page=1")
    var presenter: PhotosPresentationLogic?
    var worker: PhotosWorker?
    var photos: [Photo] = []
    
    
    func makeRequest() {
        guard let url = url else { return }
        AF.request(url, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success:
                self.parseJson(response: response)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func parseJson(response: DataResponse<Any>) {
        if let json = response.data {
            do{
                let data = try JSON(data: json)
                for photoJson in data["photos"].arrayValue {
                    if let photo = Photo(json: photoJson) {
                        self.photos.append(photo)
                    }
                }
                self.presenter?.didGetRequest(photos: self.photos)
            }
            catch{
                print("JSON error")
            }
        }
    }
    
}

extension PhotosInteractor {
  
}

