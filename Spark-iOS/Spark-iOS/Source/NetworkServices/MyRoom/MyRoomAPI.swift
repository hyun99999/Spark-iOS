//
//  MyRoomAPI.swift
//  Spark-iOS
//
//  Created by Junho Lee on 2022/01/17.
//

import Foundation
import Moya

public class MyRoomAPI {
     
    static let shared = MyRoomAPI()
    var userProvider = MoyaProvider<MyRoomService>(plugins: [MoyaLoggerPlugin()])
    
    public init() { }
    
    func myRoomFetch(roomType: String, lastID: Int, size: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        userProvider.request(.myRoomFetch(roomType: roomType, lastID: lastID, size: size)) { (result) in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeMyRoomFetchStatus(by: statusCode, data)
                completion(networkResult)

            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func judgeMyRoomFetchStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<MyRoom>.self, from: data)
        else {
            return .pathErr
        }
        
        switch statusCode {
        case 200:
            return .success(decodedData.data ?? "None-Data")
        case 400..<500:
            return .requestErr(decodedData.message)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    func myRoomCertiFetch(roomID: Int, lastID: Int, size: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        userProvider.request(.myRoomCertiFetch(roomID: roomID, lastID: lastID, size: size)) { (result) in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeMyRoomCertiFetchStatus(by: statusCode, data)
                completion(networkResult)

            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func judgeMyRoomCertiFetchStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<MyRoomCertiData>.self, from: data)
        else {
            return .pathErr
        }
        
        switch statusCode {
        case 200:
            return .success(decodedData.data ?? "None-Data")
        case 400..<500:
            return .requestErr(decodedData.message)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
}