//
//  ReviewNetworkController.swift
//  JPLL2.0
//
//  Created by Sarah Jaysmith on 2022-04-06.
//

import Foundation

class NetworkController: ObservableObject{

    @Published var product: Product = Product()
    @Published var productReview: ProductReview = ProductReview()
    
    
    let productURL = "https://axesso-axesso-amazon-data-service-v1.p.rapidapi.com/amz/amazon-lookup-product?url="
    
    func getProductInformation(url: String, infoType: String)  {
        
        var fullURL: String
        
        if infoType == "product"{
            // add extra start to URL
            fullURL = productURL + url
        } else {
            fullURL = url
        }
        
        fetchJSONData(url: fullURL, withCompletion:
            { [weak self] (data) in
                if let data = data {
                    let decoder = JSONDecoder()
                    
                    if infoType == "review"{
                        self!.productReview = (try? decoder.decode(ProductReview.self, from: data)) ?? ProductReview()
                    } else {
                        self!.product = self!.decodeJSONData(data: data, decoder: decoder)
                    }
                }
            }
        
        ) // completion
    }
    
    func decodeJSONData(data: Data, decoder: JSONDecoder)->Product{
        var product: Product
        
        product = try! JSONDecoder().decode(Product.self, from: data)
        //product? = (try? decoder.decode(Product.self, from: data))!
        
        return product
    }
    
    func fetchJSONData(url: String, withCompletion completion: @escaping (Data?) -> Void){
        
        let headers = [
            "X-RapidAPI-Host": "axesso-axesso-amazon-data-service-v1.p.rapidapi.com",
            "X-RapidAPI-Key": "2ccb1df870msh9d0e9ebe6abe412p1494f3jsn3d1672fae5ad"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                                
        cachePolicy: .useProtocolCachePolicy,
        timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data: Data?, response, error) -> Void in
           DispatchQueue.main.async {
                completion(data)
            }
            
        })

        dataTask.resume()
    }

    
}
