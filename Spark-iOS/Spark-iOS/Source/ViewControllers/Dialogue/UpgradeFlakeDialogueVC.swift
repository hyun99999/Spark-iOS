//
//  UpgradeFlakeDialogueVC.swift
//  Spark-iOS
//
//  Created by kimhyungyu on 2022/10/08.
//

import UIKit

import SnapKit

class UpgradeFlakeDialogueVC: UIViewController {

    // MARK: - Properties
    
    private let sparkFlakes: [SparkFlake] = [
        SparkFlake(leftDay: 65),
        SparkFlake(leftDay: 62),
        SparkFlake(leftDay: 58),
        SparkFlake(leftDay: 32),
        SparkFlake(leftDay: 6),
        SparkFlake(leftDay: 0)
    ]
    private var sparkUpgradeFlakes: [UpgradeFlake] = []
    
    public var leftDay: Int?
    
    private let backgroundView = UIView()
    private let collectionViewFlowlayout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowlayout)
    private let levelTitle = UILabel()
    private let subtitle = UILabel()
    private let checkButton = UIButton()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        setSparkFlakes()
        setUI()
        addTargets()
        setLayout()
        setDelegate()
        setCollectionView()
    }
}

// MARK: - Extensions

extension UpgradeFlakeDialogueVC {
    private func setUI() {
        view.backgroundColor = .sparkBlack.withAlphaComponent(0.7)
        
        collectionView.backgroundColor = .clear
        
        backgroundView.backgroundColor = .sparkWhite
        
        levelTitle.textColor = .sparkPinkred
        levelTitle.font = .enMediumItatlicFont(ofSize: 24)
        
        subtitle.tintColor = .sparkDeepGray
        subtitle.font = .p1TitleLight
        subtitle.textAlignment = .center
        subtitle.numberOfLines = 2
        
        checkButton.setTitle("확인했어요", for: .normal)
        checkButton.setTitleColor(.sparkWhite, for: .normal)
        checkButton.backgroundColor = .sparkBlack
        checkButton.titleLabel?.font = .btn1Default
        
        levelTitle.text = sparkUpgradeFlakes[0].levelText
        subtitle.text = sparkUpgradeFlakes[0].upgradeText
    }
    
    private func addTargets() {
        checkButton.addTarget(self, action: #selector(touchCheckButton), for: .touchUpInside)
    }
    
    private func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setCollectionView() {
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UpgradeFlakeCVC.self, forCellWithReuseIdentifier: Const.Cell.Identifier.upgradeFlakeCVC)
        
        collectionViewFlowlayout.collectionView?.isPagingEnabled = true
        collectionViewFlowlayout.scrollDirection = .horizontal
    }
    
    private func setSparkFlakes() {
        sparkFlakes.forEach { sparkFlake in
            sparkUpgradeFlakes.append(sparkFlake.upgrade(leftDay ?? -1))
        }
    }
    
    // MARK: - @objc Methods
    
    @objc
    private func touchCheckButton() {
        dismiss(animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension UpgradeFlakeDialogueVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (backgroundView.frame.width - 16) / 3
        let height: CGFloat = collectionView.frame.height
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 48
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let cellWidth: CGFloat = (backgroundView.frame.width - 16) / 3
        let insets: CGFloat = (collectionView.frame.width - cellWidth) / 2
        
        return UIEdgeInsets(top: 0, left: insets, bottom: 0, right: insets)
    }
}

// MARK: - UICollectionViewDelegate

extension UpgradeFlakeDialogueVC: UICollectionViewDelegate {
    // TODO: - paging 되면서 sutitle, levettitle 변경
}

// MARK: - UICollectionViewDataSource

extension UpgradeFlakeDialogueVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sparkUpgradeFlakes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Cell.Identifier.upgradeFlakeCVC, for: indexPath) as? UpgradeFlakeCVC else { return UICollectionViewCell() }
        
        cell.initCell(sparkUpgradeFlakes[indexPath.item].flakeImage)
        
        return cell
    }
}

// MARK: - Layout

extension UpgradeFlakeDialogueVC {
    private func setLayout() {
        view.addSubview(backgroundView)
        
        backgroundView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(backgroundView.snp.width).multipliedBy(1.2)
        }
        
        backgroundView.addSubviews([levelTitle, subtitle, collectionView, checkButton])
        
        collectionView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(collectionView.snp.width).multipliedBy(0.9)
        }
        
        levelTitle.snp.makeConstraints {
            $0.bottom.equalTo(collectionView.snp.bottom).offset(-72)
            $0.centerX.equalToSuperview()
        }
        
        subtitle.snp.makeConstraints {
            $0.centerY.equalTo(levelTitle.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
        }
        
        checkButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(28)
            $0.leading.trailing.equalToSuperview().inset(106)
            $0.height.equalTo(checkButton.snp.width).multipliedBy(0.4)
        }
    }
}
