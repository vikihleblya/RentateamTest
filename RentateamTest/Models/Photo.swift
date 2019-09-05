import Foundation
import SwiftyJSON

class Photo {
    let phName: String?
    let phLink: String?
    let photoUrl: URL?
    let date: Date?
    
    init?(json: JSON, date: Date) {
      guard let photographer = json["photographer"].string,
            let photographerStringUrl = json["photographer_url"].string,
            let originalPhotoStringUrl = json["src"]["large"].string
            else { return nil }
        
        self.phName = photographer
        self.phLink = photographerStringUrl
        self.photoUrl = URL(string: originalPhotoStringUrl)
        self.date = date
    }
}
