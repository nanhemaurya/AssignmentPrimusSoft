//
//  MainViewModel.swift
//  Assignment
//
//  Created by SMN Boy on 28/01/22.
//



import Foundation

protocol MainViewModelDelegate {
    func onError(error: Error)
    func onDataLoaded()
}

class MainViewModel {
    
    var appModel: AppModel? = nil
    private var data: [CollectionViewData] = []
    
    var delegate: MainViewModelDelegate? = nil
    
    func getDataCount() -> Int { return self.data.count }
    
    func getData(at: Int) -> CollectionViewData { return data[at] }
    
    var isMoreDataToShow = false
    
    private var offset = 10
    private let limit = 10
    
    func loadData() {
        let urlString = String(format: "http://sd2-hiring.herokuapp.com/api/users?offset=%d&limit=%d", offset, limit)
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, responses, error in
                if let error = error {
                    DispatchQueue.main.async {
                        self.delegate?.onError(error: error)
                    }
                } else {
                    do {
                        self.appModel = try JSONDecoder().decode(AppModel.self, from: data!)
                        self.mappingModelToCollectionViewData(appModel: self.appModel)
                        self.isMoreDataToShow = !self.appModel!.data.users.isEmpty
                        DispatchQueue.main.async {
                            self.delegate?.onDataLoaded()
                        }
                    } catch {
                        DispatchQueue.main.async {
                            self.delegate?.onError(error: error)
                        }
                    }
                }
            }.resume()
        }
    }
    
    func loadMoreData() {
        offset += 10
        loadData()
    }
    
    private func mappingModelToCollectionViewData(appModel: AppModel?) {
        appModel?.data.users.forEach { user in
            self.data.append(.init(data: UserData(imageUrl: user.image, name: user.name), appDataEnum: .toolbar))
            let isEevn = (user.items.count % 2 == 0)
            user.items.enumerated().forEach { (index,imageUrl) in
                if !isEevn && index == 0 {
                    self.data.append(.init(data: imageUrl, appDataEnum: .odd))
                } else {
                    self.data.append(.init(data: imageUrl, appDataEnum: .even))
                }
            }
        }
    }

    
}

