//
//  CitySearchTableView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 05.09.2021.
//

import UIKit
import RxCocoa

final class CitySearchTableView: UITableView {
    lazy var didSelect = PublishRelay<City>()
    
    private lazy var cities = [City]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension CitySearchTableView {
    func setup(cities: [City]) {
        self.cities = cities
        
        reloadData()
    }
}

// MARK: UITableViewDataSource
extension CitySearchTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: String(describing: CitySearchTableCell.self)) as! CitySearchTableCell
        cell.setup(city: cities[indexPath.row])
        return cell
    }
}

// MARK: UITableViewDelegate
extension CitySearchTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect.accept(cities[indexPath.row])
    }
}

// MARK: Private
private extension CitySearchTableView {
    func initialize() {
        register(CitySearchTableCell.self, forCellReuseIdentifier: String(describing: CitySearchTableCell.self))
        
        dataSource = self
        delegate = self
    }
}
