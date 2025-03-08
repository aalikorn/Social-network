//
//  NetworkReachabilityService.swift
//  Social-network
//
//  Created by Даша Николаева on 08.03.2025.
//

import Network

class NetworkReachabilityService {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "InternetConnectionMonitor")

    func isInternetAvailable(completion: @escaping (Bool) -> Void) {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                completion(true)
            } else {
                completion(false)
            }
        }
        monitor.start(queue: queue)
    }
}
