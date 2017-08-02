# FoldTableView

![](https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat) 

类似于qq好友列表的收缩效果，两种收缩效果选择

### Installation

```
pod 'FoldTableView', '~> 1.0.9'
```

### USE
```
let tableView = FoldTableView.init(frame: CGRect(x:0,y:0,width:375,height:667),style: .plain);
tableView.foldDelegate = self;
// 默认开始下标为2的组
tableView.defOpenIdx = 2;
// 在点击其他组时，是否需要关闭当前组（false不需要，true需要,默认为true）
tableView.otherIsClose = false;
self.view.addSubview(tableView);
```

### FoldTableViewDelegate

```
	//多少组
    func numberOfSectionForFoldTableView(tableView:FoldTableView) -> Int;
    
    //组高
    func foldTableView(tableView:FoldTableView,heightForHeaderInSection section:Int)-> CGFloat;
    
    //行高
    func foldTableView(tableView:FoldTableView,heightForRowAtIndexPath indexPath:IndexPath) ->CGFloat;
    
    //每组多少行
    func foldTableView(tableView:FoldTableView,numberOfRowsInSection section:Int) -> Int;
    
    //显示cell
    func foldTableView(tableView:FoldTableView,cellForRowAtIndexPath indexPath:IndexPath) -> UITableViewCell;
```

### 以下代理为可选

```
    //点击组回调事件
    func foldSectionHeaderClickAtIndex(index:Int);
    
    //每组的箭头图片
    func foldTableView(tableView:FoldTableView,arrowImageForSection section:Int) ->UIImage;
    
    //每组的标题内容
    func foldTableView(tableView:FoldTableView,titleForHeaderInSection section:Int)->String;
    
    //每组的description内容
    func foldTableView(tableView:FoldTableView,descriptionForHeaderInSection section:Int)->String;
    
    //每组的背景颜色
    func foldTableView(tableView:FoldTableView,backgroundColorForHeaderInSection section:Int)->UIColor;
    
    //点击组后，改变组的背景颜色
    func clickBackgroundColor()->UIColor;
    
    //点击组后，改变组标题的字体颜色
    func clickHeaderTitleColor()->UIColor;
    
    //每组的标题字体大小
    func foldTableView(tableView:FoldTableView,fontForTitleInSection section:Int)->UIFont;
    
    //每组的description字体大小
    func foldTableView(tableView:FoldTableView,fontForDescriptionInSection section:Int)->UIFont;
    
    //每组的标题字体颜色
    func foldTableView(tableView:FoldTableView,textColorForTitleInSection section:Int)->UIColor;
    
    //每组的description字体颜色
    func foldTableView(tableView:FoldTableView,textColorForDescriptionInSection section:Int)->UIColor;
```


