import Foundation
import SwiftyJSON

class Photo {
    let phName: String?
    let phUrl: String?
    let originalPhotoUrl: String?
    let thumbnailPhotoUrl: String?
    
    init?(json: JSON) {
        guard
            let photographer = json["photographer"].string,
            let photographer_url = json["photographer_url"].string,
            let originalPhoto = json["src"]["original"].string,
            let mediumPhoto = json["src"]["medium"].string
            else { return nil }
        
        self.phName = photographer
        self.phUrl = photographer_url
        self.originalPhotoUrl = originalPhoto
        self.thumbnailPhotoUrl = mediumPhoto
    }
}
