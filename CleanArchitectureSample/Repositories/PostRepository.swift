//
//  PostRepository.swift
//  CleanArchitectureSample
//
//  Created by Nguyen Viet Khoa on 08/04/2024.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire


protocol PostRepository {
    func getPost(id: String) -> Observable<Post>
}

class PostRepositoryImpl: PostRepository {
    func getPost(id: String) -> Observable<Post> {
        return Observable.create { observer in
            do {
                let apiCall = GetPostAPICall(postURL: id)
                let request = try apiCall.urlRequest(baseURL: "https://661401282fc47b4cf27b5a3d.mockapi.io/api/v1")
                request.responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let post = try JSONDecoder().decode(Post.self, from: data)
                            observer.onNext(post)
                            observer.onCompleted()
                        } catch {
                            observer.onError(APIError.dataDeserialization)
                        }
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
        .observe(on: MainScheduler.instance)
    }
}


struct GetPostAPICall: APICall {
    let postURL: String
    var path: String { "/posts/\(postURL)" }
    var method: HTTPMethod { .get }
    var headers: HTTPHeaders? { nil }
    func body() throws -> Parameters? { nil }
}
