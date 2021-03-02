//
//  ViewController.swift
//  jsonApp
//
//  Created by o11ev on 02.03.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
    }
    
    @IBAction func randomButtonPressed(_ sender: Any) {
        fetchImage()
    }
    
    
    private func fetchImage() {
        guard let url = URL(string: "https://aws.random.cat/meow") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            do {
                let randomImage = try JSONDecoder().decode(RandomImage.self, from: data)
                
                guard let stringURL = randomImage.file else { return }
                guard let imageURL = URL(string: stringURL) else { return }
                guard let imageData = try? Data(contentsOf: imageURL) else { return }
                
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: imageData)
                    self.activityIndicator.stopAnimating()
                }
                
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
}

