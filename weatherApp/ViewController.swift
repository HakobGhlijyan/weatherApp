//
//  ViewController.swift
//  weatherApp
//
//  Created by Hakob Ghlijyan on 16.07.2024.
//

import UIKit

import UIKit

class WeatherViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var weatherView: UIView!
    
    let weatherTypes = [NSLocalizedString("Sunny", comment: ""),
                        NSLocalizedString("Rainy", comment: ""),
                        NSLocalizedString("Stormy", comment: ""),
                        NSLocalizedString("Foggy", comment: "")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Display random weather on startup
        displayRandomWeather()
    }

    func displayRandomWeather() {
        let randomIndex = Int(arc4random_uniform(UInt32(weatherTypes.count)))
        displayWeather(at: randomIndex)
    }

    func displayWeather(at index: Int) {
        // Clear current weather view
        weatherView.subviews.forEach({ $0.removeFromSuperview() })
        
        // Create new weather animation
        let newWeatherView = createWeatherAnimation(type: weatherTypes[index])
        newWeatherView.frame = weatherView.bounds
        weatherView.addSubview(newWeatherView)
        
        // Add transition animation
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1.0
        weatherView.layer.add(transition, forKey: kCATransition)
    }

    func createWeatherAnimation(type: String) -> UIView {
        let view = UIView()
        switch type {
        case "Sunny":
            view.backgroundColor = UIColor.yellow
            // Add more sun-specific animations here
        case "Rainy":
            view.backgroundColor = UIColor.blue
            // Add more rain-specific animations here
        case "Stormy":
            view.backgroundColor = UIColor.gray
            // Add more storm-specific animations here
        case "Foggy":
            view.backgroundColor = UIColor.lightGray
            // Add more fog-specific animations here
        default:
            view.backgroundColor = UIColor.white
        }
        return view
    }

    // MARK: - UICollectionViewDelegate & DataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherTypes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as? WeatherCell {
            // Configure cell
            cell.weatherLabel.text = weatherTypes[indexPath.row]
        
            cell.backgroundColor = .lightGray // Настройте стиль вашей ячейки
                    
                    
            return cell
        } else {
            // Handle error case if casting fails
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        displayWeather(at: indexPath.row)
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: collectionView.bounds.height)
    }
}
