# AppGuid
app启动引导页面


应用首次启动时引导页添加或设置-关于-欢迎页查看，或者新功能简介等

![image](https://github.com/ShaochongDu/AppGuid/raw/master/AppGuid/DemoScreenShot.gif)

### 使用方法
```
CSAppGuidViewController *guidVC = [[CSAppGuidViewController alloc] initWithLunchImgArray:@[@"guies01",@"guies02",@"guies03"] complete:^{
  NSLog(@"AppDelegate 引导页结束");
}];
[guidVC showGuidView];
```
