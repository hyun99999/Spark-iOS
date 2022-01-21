//
//  HabitRoomMemberCVC.swift
//  Spark-iOS
//
//  Created by kimhyungyu on 2022/01/19.
//

import UIKit

class HabitRoomMemberCVC: UICollectionViewCell {

    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var tagMeImage: UIImageView!
    @IBOutlet weak var sparkCountLabel: UILabel!
    @IBOutlet weak var sparkImage: UIImageView!
    @IBOutlet weak var stickerImage: UIImageView!
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }
    
    override func prepareForReuse() {
        profileImage.image = UIImage()
        tagMeImage.isHidden = true
        nicknameLabel.text = ""
        statusLabel.text = ""
        sparkCountLabel.text = ""
        sparkCountLabel.isHidden = true
        sparkImage.image = UIImage()
        stickerImage.isHidden = true
        stickerImage.image = UIImage()
    }
}

// MARK: - Methods

extension HabitRoomMemberCVC {
    private func setUI() {
        profileImage.layer.cornerRadius = 32
        profileImage.contentMode = .scaleAspectFill
        
        nicknameLabel.font = .h3Subtitle
        nicknameLabel.textColor = .sparkBlack
        
        statusLabel.font = .p2Subtitle
        statusLabel.textColor = .sparkDarkGray
        
        sparkCountLabel.font = .captionEng
        sparkCountLabel.textColor = .sparkWhite
    }
    
    /// 내 셀 초기화
    func initCellMe(recordID: Int,
                    userID: Int,
                    profileImg: String,
                    nickname: String,
                    status: String,
                    receivedSpark: Int,
                    leftDay: Int) {
        profileImage.updateImage(profileImg)
        
        nicknameLabel.text = nickname
        
        if status == "CONSIDER" {
            statusLabel.text = "지금은 고민중이에요."
            stickerImage.image = UIImage(named: "stickerThingking")
            stickerImage.isHidden = false
        } else if status == "DONE" {
            statusLabel.text = "인증을 완료했어요!"
            stickerImage.image = UIImage(named: "stickerCompleteDefault")
            stickerImage.isHidden = false
        } else if status == "REST" {
            statusLabel.text = "오늘은 쉬어요."
            stickerImage.image = UIImage(named: "stickerRestSmallHavitroom")
            stickerImage.isHidden = false
        } else {
            if leftDay == 66 {
                statusLabel.text = "인증은 내일부터 가능해요."
                stickerImage.isHidden = true
            } else {
                statusLabel.text = "아직 인증하지 않았어요!"
                stickerImage.isHidden = true
            }
        }
        
        tagMeImage.isHidden = false
        sparkImage.image = UIImage(named: "icFireDarkgray")
        sparkCountLabel.text = "\(receivedSpark)"
        sparkCountLabel.isHidden = false
    }
    
    /// 다른 멤버 셀 초기화
    func initCellOthers(recordID: Int,
                        userID: Int,
                        profileImg: String,
                        nickname: String,
                        status: String,
                        sparkDone: Bool,
                        leftDay: Int) {
        profileImage.updateImage(profileImg)
        
        nicknameLabel.text = nickname
        
        if status == "CONSIDER" {
            statusLabel.text = "지금은 고민중이에요."
        } else if status == "DONE" {
            statusLabel.text = "인증을 완료했어요!"
        } else if status == "REST" {
            statusLabel.text = "오늘은 쉬어요."
        } else {
            if leftDay == 66 {
                statusLabel.text = "인증은 내일부터 가능해요."
                stickerImage.isHidden = true
            } else {
                statusLabel.text = "아직 인증하지 않았어요!"
                stickerImage.isHidden = true
            }
        }
        
        tagMeImage.isHidden = true
        if sparkDone {
            sparkImage.image = UIImage(named: "icFireInactive")
        } else {
            if leftDay == 66 {
                sparkImage.image = UIImage(named: "icFireInactive")
            } else {
                sparkImage.image = UIImage(named: "icFireDefault")
            }
        }
        sparkCountLabel.isHidden = true
    }
}
