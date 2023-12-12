//
//  Chuck
//
//  Created by Caio Fabrini on 27/01/23.
//

import Foundation
import Alamofire

protocol HomeServiceDelegate: AnyObject {
    func getHome(completion: @escaping (Result<[String], Error>) -> Void)
}

class HomeService: HomeServiceDelegate {
    
    func getHome(completion: @escaping (Result<[String], Error>) -> Void) {
        let url: String = "https://api.chucknorris.io/jokes/categories"
        
        AF.request(url, method: .get).validate(statusCode: 200..<300).responseDecodable(of: [String].self) { response in
            print(#function)
            debugPrint(response)
            
            switch response.result {
            case.success(let success):
                print("SUCCESS -> \(#function)")
                completion(.success(success))
            case .failure(let error):
                print("ERROR -> \(#function)")
                completion(.failure(error))
            }
        }
    }
}
