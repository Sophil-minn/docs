1. 按官网搭建环境

### Android:
1. ERROR: Failed to open zip file. 
解法: 
a. 到android/gradle/wrapper/gradle-wrapper.properties 查看 zip版本
b. 下载 http://services.gradle.org/distributions/  对应版本
c. 放到 ~/.gradle/wrapper/dist/...

react-native run-android
react-native run-ios
初次运行，大概会等个几分钟，就可以看到运行结果了
```
export ANDROID_HOME=/Users/用户名/Library/Android/sdk
export PATH=${PATH}:${ANDROID_HOME}/platform-tools
export PATH=${PATH}:${ANDROID_HOME}/tools

source .bash_profile
```

### ios
```

```