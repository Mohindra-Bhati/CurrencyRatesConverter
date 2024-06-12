//
//  SSLPinning.swift
//  CurrencyRatesConverter
//
//  Created by Mohindra Bhati on 12/06/24.
//

import Foundation

class SSLPinner: NSObject, URLSessionDelegate {
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard let serverTrust = challenge.protectionSpace.serverTrust else {
            completionHandler(.cancelAuthenticationChallenge, nil);
            return
        }
        
        let certificate = SecTrustGetCertificateAtIndex(serverTrust, 0)
        let policy = NSMutableArray()
        policy.add(SecPolicyCreateSSL(true, challenge.protectionSpace.host as CFString))
        
        let isServerTrusted = SecTrustEvaluateWithError(serverTrust, nil)
        
        let remoteCertificateData:NSData =  SecCertificateCopyData(certificate!)
        
        let pathToCertificate1 = Bundle.main.path(forResource: "openexchangerates.org", ofType: "cer")
        let pathToCertificate2 = Bundle.main.path(forResource: "apilayer.com", ofType: "cer")
        let localCertificateData1:NSData = NSData(contentsOfFile: pathToCertificate1!)!
        let localCertificateData2:NSData = NSData(contentsOfFile: pathToCertificate2!)!
        
        if(isServerTrusted && remoteCertificateData.isEqual(to: localCertificateData1 as Data)) || (isServerTrusted && remoteCertificateData.isEqual(to: localCertificateData2 as Data)){
            let credential:URLCredential =  URLCredential(trust:serverTrust)
            print("Certificate pinning is successfully completed")
            completionHandler(.useCredential,nil)
        }
        else {
            completionHandler(.cancelAuthenticationChallenge,nil)
        }
    }
}
