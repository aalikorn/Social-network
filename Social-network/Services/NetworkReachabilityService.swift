//
//  NetworkReachabilityService.swift
//  Social-network
//
//  Created by Даша Николаева on 08.03.2025.
//

import Network

// Service to monitor network reachability (internet connection status)
class NetworkReachabilityService {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "InternetConnectionMonitor")

    // Method to check if the internet connection is available
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
