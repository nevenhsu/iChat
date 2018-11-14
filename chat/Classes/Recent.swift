//
//  Recent.swift
//  chat
//
//  Created by Neven on 2018/11/12.
//  Copyright © 2018 Neven. All rights reserved.
//

import Foundation


func startPrivateChat(user1: FUser, user2: FUser) -> String {
    
    let userId1 = user1.objectId
    let userId2 = user2.objectId
    
    var chatRoomId = ""
    
    let value = userId1.compare(userId2).rawValue
    
    if value < 0 {
        chatRoomId = "\(userId1)\(userId2)"
    } else {
        chatRoomId = "\(userId2)\(userId1)"
    }
    
    let members = [userId1, userId2]
    
    // Create recent chat
    createRecent(members: members, chatRoomId: chatRoomId, withUserUserName: "", type: kPRIVATE, users: [user1, user2], avatarOfGroup: nil)
    
    return chatRoomId
}

func createRecent(members: [String], chatRoomId: String, withUserUserName: String, type: String, users: [FUser]?, avatarOfGroup: String?) {
    
    var tempMembers = members
    
    reference(.Recent).whereField(kCHATROOMID, isEqualTo: chatRoomId).getDocuments { (snapshot, error) in
        
        guard let snapshot = snapshot else { return }
        
        if !snapshot.isEmpty {
            for recent in snapshot.documents {
                let currentRecent = recent.data() as NSDictionary
                
                if let currentUserId = currentRecent[kUSERID] {
                    
                    if tempMembers.contains(currentUserId as! String) {
                        let index = tempMembers.firstIndex(of: currentUserId as! String)
                        tempMembers.remove(at: index!)
                    }
                    
                }
            }
        }
        
        for userId in tempMembers {
            // create recent items
            createRecentItems(userId: userId,chatRoomId: chatRoomId, members: members, withUserUserName: withUserUserName, type: type, users: users, avatarOfGroup: avatarOfGroup)
        }
        
    }
    
}


func createRecentItems(userId: String, chatRoomId: String, members:[String], withUserUserName: String, type: String, users: [FUser]?, avatarOfGroup: String?) {
    
    let localRefernce = reference(.Recent).document()
    let recentId = localRefernce.documentID
    
    let date = dateFormatter().string(from: Date())
    
    var recent: [String: Any]!
    
    if type == kPRIVATE {
        // private
        var withUser: FUser?
        
        if users != nil && users!.count > 0 {
            if userId == FUser.currentId() {
                // for current user
                withUser = users!.last!
            } else {
                withUser = users!.first!
            }
        }
        
        // create recent
        recent = [
            kRECENTID: recentId,
            kUSERID: userId,
            kCHATROOMID: chatRoomId,
            kMEMBERS: members,
            kMEMBERSTOPUSH: members,
            kWITHUSERUSERNAME: withUser!.fullname,
            kWITHUSERUSERID: withUser!.objectId,
            kLASTMESSAGE: "",
            kCOUNTER: 0,
            kDATE: date,
            kTYPE: type,
            kAVATAR: withUser!.avatar
        ]
        
    } else {
        // group
        
        if avatarOfGroup != nil {
            recent = [
                kRECENTID: recentId,
                kUSERID: userId,
                kCHATROOMID: chatRoomId,
                kMEMBERS: members,
                kMEMBERSTOPUSH: members,
                kWITHUSERUSERNAME: withUserUserName,
                kLASTMESSAGE: "",
                kCOUNTER: 0,
                kDATE: date,
                kTYPE: type,
                kAVATAR: avatarOfGroup!
                ] as [String: Any]
        }
    }
    
    // save recent chat
    localRefernce.setData(recent)
    
    
    
}

