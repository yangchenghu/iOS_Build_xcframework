使用方法：
1. 先在 Podfile 文件中添加需要使用的三方组件。如：`pod 'MJRefresh', '3.7.2'`
2. 使用 `pod install` 安装组件。
3. 使用 `sh buildFramework.sh MJRefresh '3.7.2'` 来构建 xcframework.


说明：
1. 如果需要构建动态库的xcframework，需要在 Podfile 中使用`use_frameworks!   :linkage => :dynamic` 标记
2. 如果需要构建动态库的xcframework，需要在 Podfile 中使用`use_frameworks!   :linkage => :static` 标记
