import Foundation

struct Heroes {

    let base: String
    let date: String

    let recents: [ResponseModel]
    let favorites: [ResponseModel]
}

struct ResponseModel {
    let idUser: Int
    let addressNeighborhood: String
    let isSuperHero: Bool
    let price: Double
    let firstName: String
    let imageURL: String
}

extension Heroes: Parceable {
    static func parseObject(dictionary: [String: AnyObject]) -> Result<Heroes, StatusResult> {
        var recentsModel: [ResponseModel] = [ResponseModel]()
        var favoritesModel: [ResponseModel] = [ResponseModel]()

        if let recents = dictionary["recents"] as? NSArray {
            recentsModel = parseModel(model: recents)
        }

        if let favorites = dictionary["favorites"] as? NSArray {
            favoritesModel = parseModel(model: favorites)
        }

        if recentsModel.count > 0 || favoritesModel.count > 0 {

            let conversion = Heroes(base: "", date: "", recents: recentsModel, favorites: favoritesModel)

            return Result.success(conversion)
        } else {
            return Result.failure(StatusResult.parser(string: "Unable to parse conversion rate"))
        }
    }

    static func parseModel(model: NSArray) -> [ResponseModel] {
        var listModel: [ResponseModel] = [ResponseModel]()
        for item in model {
            if let object = item as? [String: AnyObject] {
                let idUser: Int  = object["id"] as? Int ?? 0
                let addressNeighborhood: String = object["address_neighborhood"] as? String ?? ""
                let isSuperHero: Bool = object["is_superhero"] as? Bool ?? false
                let price: Double = object["price"] as? Double ?? 0
                if let user = object["user"] as? [String: AnyObject] {
                    let firstName: String = user["first_name"] as? String ?? ""
                    let imageURL: String = user["image_url"] as? String ?? ""
                    let response: ResponseModel = ResponseModel(idUser: idUser,
                                                                addressNeighborhood: addressNeighborhood,
                                                                isSuperHero: isSuperHero,
                                                                price: price,
                                                                firstName: firstName,
                                                                imageURL: imageURL)
                    listModel.append(response)
                }
            }
        }
        return listModel
    }
}
