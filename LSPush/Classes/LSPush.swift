//
//  LSPush.swift
//  LSPush
//
//  Created by zrf on 2021/6/16.
//

import Foundation
import MobPush
import MOBFoundation

public class LSPush {
    public static let shared = LSPush()
    
    //消息提示类型
   public struct LSPushOptions: OptionSet {
        public var rawValue: UInt
    
        public init(rawValue: UInt) {
            self.rawValue = rawValue
        }
      
        public static let none = LSPushOptions([])  //不提醒
        public static let badge = LSPushOptions(rawValue: 1 << 0) //角标提醒
        public static let sound = LSPushOptions(rawValue: 1 << 1) //声音提醒
        public static let alert = LSPushOptions(rawValue: 1 << 2) //弹框提醒
    }
 
    
    public var callback:((Dictionary<String, Any>)->Void)?
    private init(){
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveMessage(_:)), name: NSNotification.Name.MobPushDidReceiveMessage, object: nil)
    }
    /**
     @brief 配置推送
     @param key 从第三方平台获取到的AppKey
     @param secret 从第三方平台获取到的AppSecret
     @param isDebug  是否为debug模式.  默认为false，即生产模式
     @author rf/2021-06-17
     */
    public func setup(_ key: String, secret: String, isDebug: Bool = false){
        guard !key.isEmpty else {
            fatalError("MobPush AppKey必须输入")
        }
        guard !secret.isEmpty else {
            fatalError("MobPush AppSecret必须输入")
        }
        // 设置推送环境
        MobPush.setAPNsForProduction(!isDebug)
        //注册
        MobSDK.registerAppKey(key, appSecret: secret)
        //推送设置（获得角标、声音、弹框提醒权限）
        let config = MPushNotificationConfiguration()
        
//        config.types = MPushAuthorizationOptions(rawValue: MPushAuthorizationOptions.badge.rawValue | MPushAuthorizationOptions.sound.rawValue |
//            MPushAuthorizationOptions.alert.rawValue
//        )
        config.types = [.badge, .alert, .sound]
        MobPush.setupNotification(config)
        
        foregroundType([.badge, .alert, .sound])
        
    }
    
    /**
     @brief 上报隐私条款点击状态
     @param status 是否同意隐私条款
     */
    public func privacyStatus(_ status: Bool, completion:@escaping (Bool)->Void){
        MobSDK.uploadPrivacyPermissionStatus(status) { success in
            completion(success)
        }
    }
    /**
     @brief 获取注册id（可与用户id绑定，实现向指定用户推送消息）
     */
    public func getRegisterID(_ completion:@escaping (String, Error?)->Void){
        MobPush.getRegistrationID { rid, error in
            completion(rid ?? "", error)
        }
    }
    
    //MARK: 可配置方法
    /**
     @brief 设置应用进入前台后，通知展示样式
     @param type 默认为不展示 iOS 10 以后有效，iOS 10 以前本来就不展示）
     */
    public func foregroundType(_ type: LSPushOptions = []){
        MobPush.setAPNsShowForegroundType(MPushAuthorizationOptions(rawValue: type.rawValue))
    }
    /**
     @brief 设置角标到Mob服务器
     */
    public func setBadge(_ badge: UInt16){
        MobPush.setBadge(Int(badge))
    }
    /**
     @brief 清除角标，但不清空通知栏消息
     */
    public func clearBadge(){
        MobPush.clearBadge()
    }
    /**
     关闭远程推送（应用内推送和本地通知不受影响，只关闭远程推送）
     */
    public func stopPush(){
        MobPush.stop()
    }
    /**
     打开远程推送
     */
    public func openPush(){
        MobPush.restart()
    }
    // 收到通知回调
    @objc func didReceiveMessage(_ notif: Notification) -> Void {
        guard let receive = callback else {
            print("接收到通知:\(String(describing: notif.object))")
            return
        }
        
        let message: MPushMessage? = (notif.object as? MPushMessage)
        var swiftDict : [String : Any] = [:]
        if let msg = message {
            for (key, value) in msg.notification.convertDictionary() {
                swiftDict[key as! String] = value
            }
            //字典追加到swiftDict
            swiftDict.merge(msg.notification.convertDictionary() as! Dictionary) { (_ , value) in
                value
            }
        }
        receive(swiftDict)
    }
    /**
     @brief 设置别名，推送识别用户时可以使用
     @param name 需要设置的别名，不能为空
     @author rf/2021-06-18
     */
    public func setAlias(_ name: String, completion:@escaping (Error?)->Void){
        guard !name.isEmpty else {
            fatalError("别名不能为空")
        }
        MobPush.setAlias(name) { error in
            completion(error)
        }
    }
    /**
     @brief 获取别名，推送识别用户时可以使用
     @author rf/2021-06-18
     */
    public func getAlias(_  completion:@escaping (String?, Error?)->Void){
        MobPush.getAliasWithResult { name, error in
            completion(name, error)
        }
    }
    /**
     @brief 删除别名，推送识别用户时可以使用
     @author rf/2021-06-18
     */
    public func delAlias(_  completion:@escaping ( Error?)->Void){
        MobPush.deleteAlias {  error in
            completion( error)
        }
    }
    
    //MARK: - 计算属性
    /**
     @brief 当前远程推送是否关闭
     
     @return YES：推送关闭状态，NO：推送打开状态
     */
    public var bPushStop: Bool {
        MobPush.isPushStopped()
    }
    
}
