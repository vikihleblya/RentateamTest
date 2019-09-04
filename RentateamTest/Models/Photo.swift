import Foundation
import SwiftyJSON

class Photo {
    let id: Int?
    let phName: String?
    let phLink: String?
    let photoUrl: URL?
    
    init?(json: JSON) {
      guard let id = json["id"].int,
            let photographer = json["photographer"].string,
            let photographerStringUrl = json["photographer_url"].string,
            let originalPhotoStringUrl = json["src"]["large"].string
            else { return nil }
        
        self.id = id
        self.phName = photographer
        self.phLink = photographerStringUrl
        self.photoUrl = URL(string: originalPhotoStringUrl)
    }
}
