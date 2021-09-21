//
//  OnboardingView.swift
//  Nursing
//
//  Created by Andrey Chernyshev on 17.01.2021.
//

import UIKit

final class OnboardingView: UIView {
    enum Step: Int {
        case welcome, name, gender, birthdate, sign, birttime, city, findMore, feelToday, goals, marital, partnerSign, enjoying, question1, question2, question3, prePalm, palm, preloader, plan
    }
    
    var didFinish: (() -> Void)?
    
    var step = Step.welcome {
        didSet {
            scroll()
            headerUpdate()
        }
    }
    
    lazy var backgroundImageView = makeBackgroundImageView()
    lazy var scrollView = makeScrollView()
    lazy var progressView = makeProgressView()
    
    private weak var vc: UIViewController?
    
    private lazy var nameView = ONameView(step: .name)
    private lazy var genderView = OGenderView(step: .gender)
    private lazy var birthdateView = OBirthdateView(step: .birthdate)
    private lazy var signView = OSignView(step: .sign)
    private lazy var prePalmView = OPrePalmView(step: .prePalm)
    private lazy var planView = OPlanView(step: .plan)
    private lazy var contentViews: [OSlideView] = {
        [
            OWelcomeView(step: .welcome),
            nameView,
            genderView,
            birthdateView,
            signView,
            OBirthtimeView(step: .birttime),
            OCityView(step: .city),
            OFindMoreView(step: .findMore),
            OFeelTodayView(step: .feelToday),
            OGoalsView(step: .goals),
            OMaritalView(step: .marital),
            OPartnerSignView(step: .partnerSign),
            OEnjoyingView(step: .enjoying),
            OQuestionView(step: .question1, question: "Onboarding.Question1".localized),
            OQuestion2View(step: .question2, question: "Onboarding.Question2".localized),
            OQuestion3View(step: .question3, question: "Onboarding.Question3".localized),
            prePalmView,
            OPalmView(step: .palm, vc: vc),
            OPreloaderView(step: .preloader),
            planView
        ]
    }()
    
    convenience init(vc: UIViewController?) {
        self.init(frame: .zero)
        
        self.vc = vc
        
        makeConstraints()
        initialize()
        headerUpdate()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var progressCases1: [Step] = [
        .name, .gender, .birthdate, .birttime, .city
    ]
    private lazy var progressCases2: [Step] = [
        .feelToday, .goals, .marital, .partnerSign, .enjoying, .question1, .question2, .question3, .prePalm
    ]
}

// MARK: OSlideViewDelegate
extension OnboardingView: OSlideViewDelegate {
    func slideViewDidNext(from step: Step) {
        let nextRawValue = step.rawValue + 1

        guard let nextStep = Step(rawValue: nextRawValue) else {
            didFinish?()

            return
        }

        self.step = nextStep
    }
}

// MARK: OPrePalmViewDelegate
extension OnboardingView: OPrePalmViewDelegate {
    func prePalmViewDidAccessDenied() {
        step = .preloader
    }
    
    func prePalmViewDidAccessGranted() {
        slideViewDidNext(from: .prePalm)
    }
}

// MARK: Private
private extension OnboardingView {
    func initialize() {
        progressView.count = (progressCases1 + progressCases2).count
        progressView.step = 1
        
        nameView.nameDelegate = genderView
        birthdateView.birthdateDelegate = signView
        prePalmView.prePalmDelegate = self
        genderView.genderDelegate = planView
        
        contentViews
            .enumerated()
            .forEach { [weak self] index, view in
                scrollView.addSubview(view)
                
                view.delegate = self
                
                view.frame.origin = CGPoint(x: UIScreen.main.bounds.width * CGFloat(index), y: 0)
                view.frame.size = CGSize(width: UIScreen.main.bounds.width,
                                         height: UIScreen.main.bounds.height)
            }
        
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width * CGFloat(contentViews.count),
                                        height: UIScreen.main.bounds.height)
        
        progressView.skipButton.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
    }
    
    func scroll() {
        let index = step.rawValue
        
        guard contentViews.indices.contains(index) else {
            return
        }
        
        let view = contentViews[index]
        let frame = contentViews[index].frame
        
        scrollView.scrollRectToVisible(frame, animated: true)
        
        view.moveToThis()
    }
    
    func headerUpdate() {
        switch step {
        case .welcome, .plan, .sign, .findMore, .palm, .preloader:
            progressView.isHidden = true
        default:
            progressView.isHidden = false
        }
        
        let count = progressCases1.contains(step) ? progressCases1.count : progressCases2.count
        if progressView.count != count {
            progressView.count = count
        }
        
        let showSkip = progressCases2.contains(step)
        if progressView.showSkip != showSkip {
            progressView.showSkip = showSkip
        }
        
        let index = progressCases1.firstIndex(of: step) ?? progressCases2.firstIndex(of: step)
        guard let index = index else {
            return
        }
        progressView.step = index + 1
    }
    
    @objc
    func skipTapped() {
        switch step {
        case .prePalm:
            step = .preloader
        default:
            slideViewDidNext(from: step)
        }
    }
}

// MARK: Make constraints
private extension OnboardingView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 17.scale),
            progressView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -17.scale),
            progressView.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 57.scale : 30.scale),
            progressView.heightAnchor.constraint(equalToConstant: 24.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension OnboardingView {
    func makeBackgroundImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "Splash.Background")
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeScrollView() -> UIScrollView {
        let view = UIScrollView()
        view.backgroundColor = UIColor.clear
        view.isScrollEnabled = false
        view.isPagingEnabled = true
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.contentInsetAdjustmentBehavior = .never
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeProgressView() -> OStepView {
        let view = OStepView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
