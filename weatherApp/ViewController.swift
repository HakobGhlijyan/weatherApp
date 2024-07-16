//
//  ViewController.swift
//  weatherApp
//
//  Created by Hakob Ghlijyan on 16.07.2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

class WeatherViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var weatherTypes = ["Sunny", "Rainy", "Stormy", "Foggy"]
    var collectionView: UICollectionView!
    var currentWeatherView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        displayRandomWeather()
    }

    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 50, width: self.view.frame.width, height: 100), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.view.addSubview(collectionView)
    }

    func displayRandomWeather() {
        let randomIndex = Int(arc4random_uniform(UInt32(weatherTypes.count)))
        displayWeather(at: randomIndex)
    }

    func displayWeather(at index: Int) {
        // Remove existing weather view
        currentWeatherView?.removeFromSuperview()
        
        // Add new weather view
        let weatherView = UIView(frame: self.view.bounds)
        weatherView.backgroundColor = getWeatherColor(type: weatherTypes[index])
        self.view.addSubview(weatherView)
        self.view.sendSubviewToBack(weatherView)
        currentWeatherView = weatherView

        // Add animation
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1.0
        weatherView.layer.add(transition, forKey: kCATransition)
    }

    func getWeatherColor(type: String) -> UIColor {
        switch type {
        case "Sunny":
            return UIColor.yellow
        case "Rainy":
            return UIColor.blue
        case "Stormy":
            return UIColor.gray
        case "Foggy":
            return UIColor.lightGray
        default:
            return UIColor.white
        }
    }

    // MARK: - UICollectionViewDelegate & DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherTypes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .white
        
        let label = UILabel(frame: cell.contentView.frame)
        label.text = weatherTypes[indexPath.row]
        label.textAlignment = .center
        cell.contentView.addSubview(label)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        displayWeather(at: indexPath.row)
    }
}
