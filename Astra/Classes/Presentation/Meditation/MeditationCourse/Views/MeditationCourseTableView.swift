//
//  MeditationCourseTableView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 25.08.2021.
//

import UIKit
import RxCocoa

final class MeditationCourseTableView: UITableView {
    lazy var didSelect = PublishRelay<MeditationAudio>()
    
    private var elements = [MeditationCourseTableElement]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension MeditationCourseTableView {
    func setup(elements: [MeditationCourseTableElement]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UITableViewDataSource
extension MeditationCourseTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch elements[indexPath.row] {
        case .offset:
            let cell = dequeueReusableCell(withIdentifier: "OffsetTableCell")!
            cell.backgroundColor = UIColor.clear
            cell.contentView.backgroundColor = UIColor.clear
            cell.selectionStyle = .none
            return cell
        case .header(let imagePath, let title, let info):
            let cell = dequeueReusableCell(withIdentifier: String(describing: MeditationCourseHeaderCell.self)) as! MeditationCourseHeaderCell
            cell.setup(imagePath: imagePath, title: title, info: info)
            return cell
        case .text(let description):
            let cell = dequeueReusableCell(withIdentifier: String(describing: MeditationCourseDescriptionCell.self)) as! MeditationCourseDescriptionCell
            cell.setup(description: description)
            return cell
        case .audio(let audio):
            let cell = dequeueReusableCell(withIdentifier: String(describing: MeditationCourseAudioCell.self)) as! MeditationCourseAudioCell
            cell.setup(element: audio)
            return cell
        }
    }
}

// MARK: UITableViewDelegate
extension MeditationCourseTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch elements[indexPath.row] {
        case .offset(let offset):
            return offset
        case .header:
            return 290.scale
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard case let .audio(audio) = elements[indexPath.row] else {
            return
        }
        
        didSelect.accept(audio.audio)
    }
}

// MARK: Private
private extension MeditationCourseTableView {
    func initialize() {
        register(UITableViewCell.self, forCellReuseIdentifier: "OffsetTableCell")
        register(MeditationCourseHeaderCell.self, forCellReuseIdentifier: String(describing: MeditationCourseHeaderCell.self))
        register(MeditationCourseDescriptionCell.self, forCellReuseIdentifier: String(describing: MeditationCourseDescriptionCell.self))
        register(MeditationCourseAudioCell.self, forCellReuseIdentifier: String(describing: MeditationCourseAudioCell.self))
        
        dataSource = self
        delegate = self
    }
}
