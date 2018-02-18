
Aria2ForMac
===========

![](https://raw.githubusercontent.com/muyangren907/Aria2ForMac/master/screenshots/screenshots.jpg)

## 下载

  [Releases](https://github.com/muyangren907/aria2formac/releases)

## 使用

- 解压后拖到应用程序文件夹运行即可

## 说明

- 程序已集成aria2c，打开即可下载
- 未完成任务退出自动保存
- 任务完成通知

## 关于链接导出
### 浏览器导出
- Safari浏览器
[safari2aria](https://github.com/miniers/safari2aria)

- Chrome浏览器
[YAAW2 for Chrome](https://chrome.google.com/webstore/detail/yaaw2-for-chrome/mpkodccbngfoacfalldjimigbofkhgjn)

### 网盘导出
#### 插件

- 百度网盘
[BaiduExporter](https://github.com/acgotaku/BaiduExporter)
- 115网盘
[115](https://github.com/acgotaku/115)，
- 迅雷离线
~~[迅雷离线](https://github.com/binux/ThunderLixianExporter)~~

#### 说明
- 网盘插件里面的User-Agent优先级高于客户端，所以修改客户端里面User-Agent不会影响导出下载的速度，默认伪装成Transmission/2.77是为了支持BT/PT
- *max*-*connections*-*per*-server（线程数）初始值16，上限256，*split*初始值16，提高*max*-*connections*-*per*-server的值 split最好也相应的提高，如果是旧的苹果机型（机械硬盘），线程数请维持默认值，过高的线程数可能导致软件或者网络设置奔溃，如果是新的苹果机型（固态硬盘) ，可以尝试提高线程数以获取更理想的下载速度， 新加入*max-tries retry-wait*两个启动项
- 百度网盘对于插件进行了某些限制，不登陆的情况直接报header错误，登录后第一次会弹验证码之后就正常了，会员暂时没发现有什么限制，具体参考https://github.com/acgotaku/BaiduExporter/issues/547

## 致谢 

- [Aria2](https://aria2.github.io)
- [Aria2GUI](https://github.com/yangshun1029/aria2gui)
- [fakeThunder](https://github.com/MartianZ/fakeThunder)
- [MacGap](https://github.com/MacGapProject)
- [webui-aria2](https://github.com/ziahamza/webui-aria2)

## 许可证

Aria2ForMac is licensed under [MIT License](http://choosealicense.com/licenses/mit/) 

