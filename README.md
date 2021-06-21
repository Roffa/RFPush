# LSPush

[![CI Status](https://img.shields.io/travis/zrf/LSPush.svg?style=flat)](https://travis-ci.org/zrf/LSPush)
[![Version](https://img.shields.io/cocoapods/v/LSPush.svg?style=flat)](https://cocoapods.org/pods/LSPush)
[![License](https://img.shields.io/cocoapods/l/LSPush.svg?style=flat)](https://cocoapods.org/pods/LSPush)
[![Platform](https://img.shields.io/cocoapods/p/LSPush.svg?style=flat)](https://cocoapods.org/pods/LSPush)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

LSPush is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'LSPush'

```
为保证您在集成MobSDK之后，能够满足工信部相关合规要求，您应确保在App安装后首次冷启动时，在用户阅读您的《隐私政策》并取得用户授权之后，调用提交隐私协议函数uploadPrivacyPermissionStatus提交隐私协议。反之，如果用户不同意《隐私政策》授权，则不能调用uploadPrivacyPermissionStatus提交隐私协议

[Mob合规指南](https://www.mob.com/wiki/detailed?wiki=MobTechprivacypushios&id=136)
[Mob集成文档](https://www.mob.com/wiki/detailed?wiki=iOSfastjoijoij2222&id=136)
[推送证书设置](https://new.dashboard.mob.com/#/mobPush/pushSet)

由于mob库不支持Swift,每次更新本地framework，需要执行 pod lib lint  , 通过podspec动态生产module

## 使用
```
//配置推送服务
isDebug: 是否为测试环境，使用时根据APP环境选择
LSPush.shared.setup("3353f291f1400", secret: "c7beb66fffaa42c7eb5ca8da24c3dac0", isDebug: true)

//上报隐私弹框操作结果，当同意隐私传入TRUE时可以使用
LSPush.shared.privacyStatus(true) { succ in
            print("上报到mob结果为:\(succ)")
        }

//获取到推送内容时回调
LSPush.shared.callback = { (info: Dictionary) -> Void in
     print("获取到推送内容:\(info["body"]!)")
     return
}

//测试，非必要实现方法。
LSPush.shared.getRegisterID { rid, error in
      print("得到的rid:" + rid)
}

//默认进入前台接收到消息时会弹框提示，如需关闭,调用下面方法
LSPush.shared.foregroundType([])
```

## Author

zrf, zhourongfeng@021.com

## License

LSPush is available under the MIT license. See the LICENSE file for more info.
