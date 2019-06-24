//
//  StorePurchaseManager.swift
//  
//
//  Created by YYang1 on 5/2/19.
//  Copyright © 2019 PixelForceSystems. All rights reserved.
//

import Foundation
import StoreKit




class StorePurchaseManager: NSObject{
    static let shared = StorePurchaseManager()
    var didGetReciept: ((String?)-> Void)?
    var receiptRelay = PublishRelay<String?>()
    var restoreReceiptRelay = PublishRelay<String?>()
    var productRelay = PublishRelay<[SKProduct]>()
    fileprivate var skRequest:SKProductsRequest?
    fileprivate var ids: [String]!
    fileprivate var recepts: [String]?
    
    
    private override init(){
        super.init()
        SKPaymentQueue.default().add(self as SKPaymentTransactionObserver)
    }
    
    deinit {
        SKPaymentQueue.default().remove(self as SKPaymentTransactionObserver)
    }
}


extension StorePurchaseManager{
    
    func paymentCheck()-> Bool {
        return SKPaymentQueue.canMakePayments()
    }
    
    func requestProductsInfoFromStore(productIds: [String]){
        ids = productIds
        let sets:Set<String> = NSSet(array: productIds) as! Set<String>
        skRequest = SKProductsRequest(productIdentifiers: sets)
        skRequest?.delegate = self
        skRequest?.start()
    }
    
    func buyProduct( _ product:SKProduct, withApplicationUsername username: String?){
        let skpay = SKMutablePayment(product: product)
//        skpay.applicationUsername = username
        SKPaymentQueue.default().add(skpay)
    }

   
    func restoreTransactions(withApplicationUsername username: String?) {
        self.recepts = Array()
//        SKPaymentQueue.default().restoreCompletedTransactions(withApplicationUsername: username)
        SKPaymentQueue.default().restoreCompletedTransactions()

    }
    
}

extension StorePurchaseManager {
    
    fileprivate func buyAppleProductSuccessWithPaymnetTransaction(_ paymentTransaction:SKPaymentTransaction) {
        if let name = paymentTransaction.payment.applicationUsername{
            YYLog("applicationUsername ===============>>>>>>>>>\(name)")
        }
        if let url = Bundle.main.appStoreReceiptURL {
            if let receiptStr = NSData(contentsOf: url)?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0)),
                let str = receiptStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
                //                YYLog("Recipt ----->> \n \(str)")
                didGetReciept?(str)
                receiptRelay.accept(str)
            }
        }
        
    }
    
    fileprivate func restoreAppleProductSuccessWithPaymnetTransaction(_ paymentTransaction:SKPaymentTransaction) {
        YYLog("applicationUsername ===============>>>>>>>>>\(String(describing: paymentTransaction.payment.applicationUsername))")
        if let url = Bundle.main.appStoreReceiptURL {
            if let receiptStr = NSData(contentsOf: url)?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0)),
                let str = receiptStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
                self.recepts?.append(str)
            }
        }
        
    }
    
}


extension StorePurchaseManager: SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let products = response.products
        productRelay.accept(response.products)
        
        products.forEach { (p) in
            YYLog("FormatterPrice " + p.localizedPrice!)

            if #available(iOS 11.2, *) {
                YYLog("""
                    ID: \(p.productIdentifier)"
                    Description: \(p.localizedDescription)
                    Title: \(p.localizedTitle)
                    Price: \(p.price)
                    CountryName: \(p.displayCountryName ?? "")
                    PriceLocale: \(p.priceLocale.currencyCode ?? "")
                    IntroductoryPrice: \(String(describing: p.introductoryPrice))
                    SubscriptionPeriod: \(String(describing: p.subscriptionPeriod))
                    Unit: \(String(describing: p.subscriptionPeriod?.unit.rawValue))
                    """)
            } else {
                YYLog("""
                    ID: \(p.productIdentifier)"
                    Description: \(p.localizedDescription)
                    Title: \(p.localizedTitle)
                    Price: \(p.price)
                    CountryName: \(p.displayCountryName ?? "")
                    PriceLocale: \(p.priceLocale.currencyCode ?? "")
                    """)
            }
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction:SKPaymentTransaction in transactions {
            if let error = transaction.error, let skError = (error as? SKError){
                YYLog("PaymentQueueError ===========>>>>>>>>\(skError.code.rawValue)")
            }
            switch transaction.transactionState {
            case .purchasing:
                YYLog("Purchasing")
            case .purchased:
                YYLog("Purchased")
                self.buyAppleProductSuccessWithPaymnetTransaction(transaction)
                queue.finishTransaction(transaction)
            case .failed:
                YYLog("Failed")
                receiptRelay.accept(nil)
                queue.finishTransaction(transaction)
            case .restored:
                YYLog("Restored")
                self.restoreAppleProductSuccessWithPaymnetTransaction(transaction)
                queue.finishTransaction(transaction)
            case .deferred:
                YYLog("Deferred")
                queue.finishTransaction(transaction)
            }
        }
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        YYLog("RestoreCompletedTransactionsFinished")
        restoreReceiptRelay.accept(self.recepts?.first)
        didGetReciept?(self.recepts?.first)
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        YYLog("RestoreCompletedTransactionsFailed")
        restoreReceiptRelay.accept(self.recepts?.first)
        didGetReciept?(self.recepts?.first)
    }
    
    
}
