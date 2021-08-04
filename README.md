# 基于 SwiftUI 的轮播图

使用:
```swift
/// 创建轮播图
/// - Parameter imagesUrl: 显示图片地址数据
/// - Parameter spacing: 图片间距(可选)
/// - Parameter cornerRadius: 图片圆角(可选)
/// - Parameter isAuto: 是否自动播放(可选)
/// - Parameter imageTapGesture: 图片点击回调
XGCycleScrollView(imagesUrl: [], spacing: 12, cornerRadius: 12, isAuto: true, imageTapGesture: { index in
    print("click image at index: \(index)")
})
```