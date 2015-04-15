ExpandingDataSource
==================

This class can help developer create a expading table(like the table view below) view easily.
`ExpandingDataSource` can control two types of cell which was provided by you. It also provides you two select delegate tells you which cell does user select.

***Attention*** You can create two cell by storyboard or code. but you should set their Identifier to `ExpandingCellIdentifier` or `ExpandedCellIdentifier` so that `ExpandingDataSource` could see whitch one is expand cell.

Install
=====
You can install it by using pod.
```
platform :ios, '7.0'
pod 'ExpandingDataSource',:git => "https://github.com/zzycami/ExpandingDataSource"
```


这是一个帮助开发者快速创建一个可展开的列表项.如下图。
![](https://raw.githubusercontent.com/zzycami/ExpandingDataSource/master/IMG_0064.PNG)
基本的实现思路就是创建两种类型的cell，然后通过控制数据源和点选事件来动态添加和去除附加cell。所以为了便于使用和扩展这里封装了一个`UITableView`的数据源。在实际使用的时候你只需继承	`ExpandingDataSource`提供扩展和普通的两种`UITableViewCell`和两种选中事件来完成你自己的逻辑事件。扩展逻辑由ExpandingDataSource来完成.

***注意***你可以通过storyboard 或者代码来创建cell。但是你需要将cell的表示码设置成
`ExpandingCellIdentifier`或者`ExpandedCellIdentifier`。这样ExpandingDataSource

安装
====
可以使用pod进行安装
```
platform :ios, '7.0'
pod 'ExpandingDataSource',:git => "https://github.com/zzycami/ExpandingDataSource"
```

