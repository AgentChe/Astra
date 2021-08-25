//
//  MeditationDashboardCollectionView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 24.08.2021.
//

import UIKit

final class MeditationDashboardCollectionView: UICollectionView {
    lazy var elements = [MeditationDashboardCollectionSection]()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension MeditationDashboardCollectionView {
    func setup(elements: [MeditationDashboardCollectionSection]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UICollectionViewDataSource
extension MeditationDashboardCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        elements[section].elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch elements[indexPath.section].elements[indexPath.row] {
        case .offset:
            let cell = dequeueReusableCell(withReuseIdentifier: String(describing: UICollectionViewCell.self), for: indexPath)
            cell.backgroundColor = UIColor.clear
            cell.contentView.backgroundColor = UIColor.clear
            
            let selectedView = UIView()
            selectedView.backgroundColor = UIColor.clear
            cell.selectedBackgroundView = selectedView
            
            return cell
        case .daily(let daily):
            let cell = dequeueReusableCell(withReuseIdentifier: String(describing: MeditationDashboardDailyCell.self), for: indexPath) as! MeditationDashboardDailyCell
            cell.setup(element: daily)
            return cell
        case .title(let title):
            let cell = dequeueReusableCell(withReuseIdentifier: String(describing: MeditationDashboardTitleCell.self), for: indexPath) as! MeditationDashboardTitleCell
            cell.setup(element: title)
            return cell
        case .subTitle(let subTitle):
            let cell = dequeueReusableCell(withReuseIdentifier: String(describing: MeditationDashboardSubTitleCell.self), for: indexPath) as! MeditationDashboardSubTitleCell
            cell.setup(element: subTitle)
            return cell
        case .course(let course):
            let cell = dequeueReusableCell(withReuseIdentifier: String(describing: MeditationDashboardCourseCell.self), for: indexPath) as! MeditationDashboardCourseCell
            cell.setup(element: course)
            return cell
        case .audio(let audio):
            let cell = dequeueReusableCell(withReuseIdentifier: String(describing: MeditationDashboardAudioCell.self), for: indexPath) as! MeditationDashboardAudioCell
            cell.setup(element: audio)
            return cell
        }
    }
}

// MARK: UICollectionViewDataSource
extension MeditationDashboardCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch elements[indexPath.section].elements[indexPath.row] {
        case .offset(let height):
            return CGSize(width: 343.scale, height: height)
        case .daily:
            return CGSize(width: 343.scale, height: 175.scale)
        case .title(let title):
            return CGSize(width: 343.scale,
                          height: MeditationDashboardTitleCell
                            .calculateHeight(width: 343.scale,
                                             string: title))
        case .subTitle(let subTitle):
            return CGSize(width: 343.scale,
                          height: MeditationDashboardSubTitleCell
                            .calculateHeight(width: 343.scale,
                                             string: subTitle))
        case .course(let course):
            return CGSize(width: 343.scale,
                          height: MeditationDashboardCourseCell
                            .calculateHeight(width: 343.scale,
                                             course: course))
        case .audio:
            return CGSize(width: 167.scale, height: 195.scale)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        guard section == 1 else {
            return 0
        }
        
        return 12.scale
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        guard section == 1 else {
            return 0
        }
        
        return 9.scale
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 16.scale, bottom: 0, right: 16.scale)
    }
}

// MARK: Private
private extension MeditationDashboardCollectionView {
    func initialize() {
        dataSource = self
        delegate = self
        
        register(UICollectionViewCell.self, forCellWithReuseIdentifier: String(describing: UICollectionViewCell.self))
        register(MeditationDashboardDailyCell.self, forCellWithReuseIdentifier: String(describing: MeditationDashboardDailyCell.self))
        register(MeditationDashboardTitleCell.self, forCellWithReuseIdentifier: String(describing: MeditationDashboardTitleCell.self))
        register(MeditationDashboardSubTitleCell.self, forCellWithReuseIdentifier: String(describing: MeditationDashboardSubTitleCell.self))
        register(MeditationDashboardCourseCell.self, forCellWithReuseIdentifier: String(describing: MeditationDashboardCourseCell.self))
        register(MeditationDashboardAudioCell.self, forCellWithReuseIdentifier: String(describing: MeditationDashboardAudioCell.self))
    }
}
