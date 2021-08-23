//
//  SignsPickerView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 23.08.2021.
//

import UIKit

// MARK: - Protocols
// MARK: AKPickerViewDataSource
/**
Protocols to specify the number and type of contents.
*/
@objc public protocol AKPickerViewDataSource {
    func numberOfItemsInPickerView(_ pickerView: AKPickerView) -> Int
}

// MARK: AKPickerViewDelegate
/**
Protocols to specify the attitude when user selected an item,
and customize the appearance of labels.
*/
@objc public protocol AKPickerViewDelegate: UIScrollViewDelegate {
    @objc optional func pickerView(_ pickerView: AKPickerView, didSelectItem item: Int)
}

// MARK: AKCollectionViewLayout
/**
Private. A subclass of UICollectionViewFlowLayout used in the collection view.
*/
private class AKCollectionViewLayout: UICollectionViewFlowLayout {
    var width: CGFloat!
    var midX: CGFloat!
    var maxAngle: CGFloat!

    func initialize() {
        self.sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        self.scrollDirection = .horizontal
        self.minimumLineSpacing = 0.0
    }

    override init() {
        super.init()
        self.initialize()
    }

    required init!(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }

    fileprivate override func prepare() {
        let visibleRect = CGRect(origin: self.collectionView!.contentOffset, size: self.collectionView!.bounds.size)
        self.midX = visibleRect.midX;
        self.width = visibleRect.width / 2;
        self.maxAngle = CGFloat(Double.pi/2);
    }

    fileprivate override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}

// MARK: AKPickerViewDelegateIntercepter
/**
Private. Used to hook UICollectionViewDelegate and throw it AKPickerView,
and if it conforms to UIScrollViewDelegate, also throw it to AKPickerView's delegate.
*/
private class AKPickerViewDelegateIntercepter: NSObject, UICollectionViewDelegate {
    weak var pickerView: AKPickerView?
    weak var delegate: UIScrollViewDelegate?

    init(pickerView: AKPickerView, delegate: UIScrollViewDelegate?) {
        self.pickerView = pickerView
        self.delegate = delegate
    }

    fileprivate override func forwardingTarget(for aSelector: Selector) -> Any? {
        if self.pickerView!.responds(to: aSelector) {
            return self.pickerView
        } else if self.delegate != nil && self.delegate!.responds(to: aSelector) {
            return self.delegate
        } else {
            return nil
        }
    }

    fileprivate override func responds(to aSelector: Selector) -> Bool {
        if self.pickerView!.responds(to: aSelector) {
            return true
        } else if self.delegate != nil && self.delegate!.responds(to: aSelector) {
            return true
        } else {
            return super.responds(to: aSelector)
        }
    }

}

// MARK: - AKPickerView
// TODO: Make these delegate conformation private
/**
Horizontal picker view. This is just a subclass of UIView, contains a UICollectionView.
*/
public class AKPickerView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // MARK: - Properties
    // MARK: Readwrite Properties
    /// Readwrite. Data source of picker view.
    public weak var dataSource: AKPickerViewDataSource? = nil
    /// Readwrite. Delegate of picker view.
    public weak var delegate: AKPickerViewDelegate? = nil {
        didSet(delegate) {
            self.intercepter.delegate = delegate
        }
    }

    /// Readwrite. A boolean value indicates whether the mask is disabled.
    public var maskDisabled: Bool! = nil {
        didSet {
            self.collectionView.layer.mask = self.maskDisabled == true ? nil : {
                let maskLayer = CAGradientLayer()
                maskLayer.frame = self.collectionView.bounds
                maskLayer.colors = [
                    UIColor.clear.cgColor,
                    UIColor.black.cgColor,
                    UIColor.black.cgColor,
                    UIColor.clear.cgColor]
                maskLayer.locations = [0.0, 0.33, 0.66, 1.0]
                maskLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
                maskLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
                return maskLayer
                }()
        }
    }

    // MARK: Readonly Properties
    /// Readonly. Index of currently selected item.
    public private(set) var selectedItem: Int = 0
    /// Readonly. The point at which the origin of the content view is offset from the origin of the picker view.
    public var contentOffset: CGPoint {
        get {
            return self.collectionView.contentOffset
        }
    }

    // MARK: Private Properties
    /// Private. A UICollectionView which shows contents on cells.
    var collectionView: UICollectionView!
    /// Private. An intercepter to hook UICollectionViewDelegate then throw it picker view and its delegate
    fileprivate var intercepter: AKPickerViewDelegateIntercepter!
    /// Private. A UICollectionViewFlowLayout used in picker view's collection view.
    fileprivate var collectionViewLayout: AKCollectionViewLayout {
        AKCollectionViewLayout()
    }

    // MARK: - Functions
    // MARK: View Lifecycle
    /**
    Private. Initializes picker view's subviews and friends.
    */
    fileprivate func initialize() {
        self.collectionView?.removeFromSuperview()
        self.collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: self.collectionViewLayout)
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.backgroundColor = UIColor.clear
        self.collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        self.collectionView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        self.collectionView.dataSource = self
        self.addSubview(self.collectionView)

        self.intercepter = AKPickerViewDelegateIntercepter(pickerView: self, delegate: self.delegate)
        self.collectionView.delegate = self.intercepter

        self.maskDisabled = self.maskDisabled == nil ? false : self.maskDisabled
    }

    public init() {
        super.init(frame: CGRect.zero)
        self.initialize()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }

    public required init!(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }

    deinit {
        self.collectionView.delegate = nil
    }

    // MARK: Layout
    open override func layoutSubviews() {
        super.layoutSubviews()
        if self.dataSource != nil && self.dataSource!.numberOfItemsInPickerView(self) > 0 {
            self.collectionView.collectionViewLayout = self.collectionViewLayout
            self.scrollToItem(self.selectedItem, animated: false)
        }
        self.collectionView.layer.mask?.frame = self.collectionView.bounds
    }

    // MARK: View Controls
    /**
    Reload the picker view's contents and styles. Call this method always after any property is changed.
    */
    public func reloadData() {
        self.invalidateIntrinsicContentSize()
        self.collectionView.collectionViewLayout.invalidateLayout()
        self.collectionView.reloadData()
        if self.dataSource != nil && self.dataSource!.numberOfItemsInPickerView(self) > 0 {
            self.selectItem(self.selectedItem, animated: false, notifySelection: false)
        }
    }

    /**
    Move to the cell whose index is given one without selection change.
    :param: item     An integer value which indicates the index of cell.
    :param: animated True if the scrolling should be animated, false if it should be immediate.
    */
    public func scrollToItem(_ item: Int, animated: Bool = false) {
        self.collectionView.scrollToItem(
            at: IndexPath(
                item: item,
                section: 0),
            at: .centeredHorizontally,
            animated: animated)
    }

    /**
    Select a cell whose index is given one and move to it.
    :param: item     An integer value which indicates the index of cell.
    :param: animated True if the scrolling should be animated, false if it should be immediate.
    */
    public func selectItem(_ item: Int, animated: Bool = false) {
        self.selectItem(item, animated: animated, notifySelection: true)
    }

    /**
    Private. Select a cell whose index is given one and move to it, with specifying whether it calls delegate method.
    :param: item            An integer value which indicates the index of cell.
    :param: animated        True if the scrolling should be animated, false if it should be immediate.
    :param: notifySelection True if the delegate method should be called, false if not.
    */
    func selectItem(_ item: Int, animated: Bool, notifySelection: Bool) {
        self.collectionView.selectItem(
            at: IndexPath(item: item, section: 0),
            animated: animated,
            scrollPosition: UICollectionView.ScrollPosition())
        self.scrollToItem(item, animated: animated)
        self.selectedItem = item
        if notifySelection {
            self.delegate?.pickerView?(self, didSelectItem: item)
        }
    }

    // MARK: Delegate Handling
    /**
    Private.
    */
    fileprivate func didEndScrolling() {
        let center = self.convert(self.collectionView.center, to: self.collectionView)
        if let indexPath = self.collectionView.indexPathForItem(at: center) {
            self.selectItem(indexPath.item, animated: true, notifySelection: true)
        }
    }

    // MARK: UICollectionViewDataSource
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.dataSource != nil && self.dataSource!.numberOfItemsInPickerView(self) > 0 ? 1 : 0
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource != nil ? self.dataSource!.numberOfItemsInPickerView(self) : 0
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }

    // MARK: UICollectionViewDelegateFlowLayout
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 50.scale, height: 50.scale)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let number = self.collectionView(collectionView, numberOfItemsInSection: section)
        let firstIndexPath = IndexPath(item: 0, section: section)
        let firstSize = self.collectionView(collectionView, layout: collectionView.collectionViewLayout, sizeForItemAt: firstIndexPath)
        let lastIndexPath = IndexPath(item: number - 1, section: section)
        let lastSize = self.collectionView(collectionView, layout: collectionView.collectionViewLayout, sizeForItemAt: lastIndexPath)
        return UIEdgeInsets(
            top: 0, left: (collectionView.bounds.size.width - firstSize.width) / 2,
            bottom: 0, right: (collectionView.bounds.size.width - lastSize.width) / 2
        )
    }

    // MARK: UICollectionViewDelegate
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectItem(indexPath.item, animated: true)
    }

    // MARK: UIScrollViewDelegate
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.didEndScrolling()
    }

    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.didEndScrolling()
        }
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        self.collectionView.layer.mask?.frame = self.collectionView.bounds
        CATransaction.commit()
    }
}
