//
//  CacheManager.swift
//  CurrencyRatesConverte
//
//  Created by Mohindra Bhati on 12/06/24.
//

import Foundation

final class CacheManager {
    static let sharedInstance = CacheManager()
    
    private let fileManager = FileManager.default
    private let cacheFileName = "get_latest_rates.json"
    private let refreshInterval: TimeInterval = 1800 // 30 minutes
    private var lastFetchDate: Date?
    private var cacheObject: ExchangeRatesResponse? = nil
    
    private init(lastFetchDate: Date? = nil, cacheObject: ExchangeRatesResponse? = nil) {
        self.lastFetchDate = lastFetchDate
        self.cacheObject = cacheObject
        loadFromDisk()
    }
    
    func getObject() -> ExchangeRatesResponse? {
        if let cachedResponse = cacheObject {
            return cachedResponse
        }
        return nil
    }
    
    func saveObject(_ response: ExchangeRatesResponse) {
        self.lastFetchDate = Date()
        let filePath = cacheFilePath()
        do {
            let data = try JSONEncoder().encode(response)
            try data.write(to: filePath)
        } catch {
            debugPrint("Failed to save data to disk: \(error)")
        }
    }
    
    private func cacheFilePath() -> URL {
        let cachesDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        return cachesDirectory.appendingPathComponent(cacheFileName)
    }
    
    private func loadFromDisk() {
        let filePath = cacheFilePath()
        if isFileOutdated(at: filePath), Reachability.isConnectedToNetwork() {
            deleteCacheFile(at: filePath)
        } else {
            do {
                let data = try Data(contentsOf: filePath)
                let exchangeRates = try JSONDecoder().decode(ExchangeRatesResponse.self, from: data)
                cacheObject = exchangeRates
                if let attributes = try? fileManager.attributesOfItem(atPath: filePath.path),
                   let modificationDate = attributes[.modificationDate] as? Date {
                    lastFetchDate = modificationDate
                }
            } catch {
                debugPrint("Failed to load data from disk: \(error)")
            }
        }
    }
    
    private func isFileOutdated(at path: URL) -> Bool {
        do {
            let attributes = try fileManager.attributesOfItem(atPath: path.path)
            if let modificationDate = attributes[.modificationDate] as? Date {
                return Date().timeIntervalSince(modificationDate) > refreshInterval
            }
        } catch {
            debugPrint("Failed to get file attributes: \(error)")
        }
        return true
    }
    
    private func deleteCacheFile(at path: URL) {
        do {
            try fileManager.removeItem(at: path)
        } catch {
            debugPrint("Failed to delete file: \(error)")
        }
    }
}
