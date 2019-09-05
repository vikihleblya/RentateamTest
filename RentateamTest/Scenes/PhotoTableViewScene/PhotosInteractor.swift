import UIKit
import Alamofire
import SwiftyJSON

protocol PhotosBusinessLogic
{
    func makeRequest(photosCount: Int)
    func parseJson(response: DataResponse<Any>)
}

protocol PhotosDataStore {
    func getDataOfImage(id: String?) -> Date
}

class PhotosInteractor: PhotosBusinessLogic, PhotosDataStore {
    
    private let headers: HTTPHeaders = ["Authorization": "563492ad6f917000010000014926874ef5ab4f26bcb8591f7b00b5e5"]
    private let photosPerOneFetch = 15
    private let cacheForDates = NSCache<NSString, NSDate>()
    private var photos: [Photo] = []
    var presenter: PhotosPresentationLogic?
    
    
    
    
    func makeRequest(photosCount: Int) {
        print("AF | Fetch images from page number: \(photosCount / photosPerOneFetch) | Photos count: \(photosCount)")
        guard let url = createUrl(perPage: photosPerOneFetch, page: photosCount / photosPerOneFetch) else { return }
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
                print("AF | Count of fetched photos: \(data["photos"].count)")
                for photoJson in data["photos"].arrayValue {
                    if let photo = Photo(json: photoJson, date: getDataOfImage(id: photoJson["src"]["large"].string)) {
                        self.photos.append(photo)
                    }
                }
                self.presenter?.didGetRequest(photos: self.photos)
                self.photos.removeAll()
            }
            catch{
                print("JSON error")
            }
        }
    }
    
    func createUrl(perPage: Int, page: Int) -> URL? {
        let queryItems = [URLQueryItem(name: "per_page", value: "\(perPage)"), URLQueryItem(name: "page", value: "\(page)")]
        let urlComps = NSURLComponents(string: "https://api.pexels.com/v1/curated")!
        urlComps.queryItems = queryItems
        let url = urlComps.url
        return url
    }
    
}

extension PhotosInteractor {
    func getDataOfImage(id: String?) -> Date {
        guard let id = id else { return Date() }
        if let cachedVersion = cacheForDates.object(forKey: id as NSString) {
            return cachedVersion as Date
        } else {
            let date = Date()
            cacheForDates.setObject(date as NSDate, forKey: id as NSString)
            return date
        }
    }
}

