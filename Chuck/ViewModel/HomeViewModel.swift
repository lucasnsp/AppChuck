//
//  Chuck
//
//  Created by Caio Fabrini on 27/01/23.
//

import UIKit

protocol HomeViewModelProtocol: AnyObject{
    func success()
    func error(message: String)
}

class HomeViewModel {

    private var categoryList: [String] = []
    private weak var delegate: HomeViewModelProtocol?
    private var service: HomeServiceDelegate
    
    init(service: HomeServiceDelegate) {
        self.service = service
    }
    
    public func delegate(delegate: HomeViewModelProtocol?){
        self.delegate = delegate
    }
    
    public func fetchRequest() {
        service.getHome { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                self.categoryList = success
                self.delegate?.success()
                print("Parabéns apresentou seus dados")
                print(result)
                
            case .failure(let failure):
                self.delegate?.error(message: failure.localizedDescription)
                print("Deu Ruim: \(failure.localizedDescription)")
            }
        }
    }
 
    public var numberOfRowsInSection: Int {
        categoryList.count
    }
    
    public func loadCurrentCategory(indexPath:IndexPath) -> String {
        categoryList[indexPath.row]
    }

}
