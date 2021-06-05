//
//  AppInterface.h
//  YBGMobileCampus
//
//  Created by 酷酷的1xd on 17/3/15.
//  Copyright © 2017年 YBG. All rights reserved.
//

#ifndef AppInterface_h
#define AppInterface_h

/////UTON智能云接口地址（测试用）--公司wifi条件下，需先扫描到设备绑定了设备，地址就用http：//设备ip
#define UTONCompanyService @"http://47.113.117.144"//wifi情况下地址用设备ip
//外网4g条件下视频音频文件这些的用公共域名：http://common.uton.net/+hash
//其他可用http://heshu.natapp1.cc/+url
#define UTONPublicApiService @"heshu.natapp1.cc"//测试地址
/*
 真实地址：局域网搜索设备返回的信息里面：但处于局域网wifi条件下用设备的ip，当处于4g流量条件下用设备返回的远程地址，如："remote":"http://heshu.natapp1.cc"
 **/
///用户注册
#define kUserRegistion @"/cloud/user/register"

//用户登录
#define kUserLogin @"/cloud/user/login"

///用户登出
#define kUserLogout @"/cloud/user/logout"

///用户删除
#define kUserDelete @"/cloud/user/delete"


///用户列表
#define kUserList @"/cloud/user/list"

///用户详情
#define kUserDetail @"/cloud/user/detail"

///用户修改手机号
#define kModifyPhoneNum    @"/cloud/user/account/modify"

///用户修改密码
#define kModifyPassword  @"/cloud/user/password/modify"


//切换管理员
#define kModifyUser @"/cloud/user/admin/modify"

//用户修改头像
#define kUserModifyAvatar   @"/cloud/user/avatar/modify"

//用户修改昵称
#define kModifyNickName @"/cloud/user/nickname/modify"

//修改用户状态
#define kModifyUserStatus @"/cloud/user/status/modify"

//用户忘记密码
#define kForgetPassword   @"/cloud/user/password/forget"

//创建文件/文件夹
#define kCreatFile @"/cloud/file/create"

//软删除文件/文件夹
#define kSoftDeleteFile    @"/cloud/file/soft/delete"

//文件/文件夹复制
#define kCopyFile  @"/cloud/file/copy"

//文件/文件夹剪切
#define kCutFile @"/cloud/file/cut"

//文件/文件夹粘贴
#define kPasteFile   @"/cloud/file/paste"

//文件/文件夹重命名
#define kRenameFile    @"/cloud/file/rename"

//文件/文件夹搜索
#define kSearchFile  @"/cloud/file/search"

//文件哈希搜索
#define kFileHashSearch  @"/cloud/file/hash/search"


///文件分类列表
#define kFileList @"/cloud/file/list"

///文件详情
#define kFileDetail @"/cloud/file/detail"

///文件修改
#define kModifyFile @"/cloud/file/modify"

///上传升级文件
#define kUploadFile @"/cloud/file/upload"

//文件时光轴列表
#define kFileTimeList @"/cloud/file/timeaxis/list"

///文件后缀列表
#define kFileExtList @"/cloud/file/ext/list"

///最近上传文件列表
#define kFileRecentList @"/cloud/file/recent/list"

///设备详情
#define kDeviceDetail @"/cloud/device/detail"

///设备磁盘详情
#define kDiskDetail @"/cloud/device/disk/detail"

///设备 CPU 详情
#define kCpuDetail @"/cloud/device/cpu/detail"

///设备内存详情
#define kMemoryDetail @"/cloud/device/memory/detail"

///设备网络详情
#define kNetDetail @"/cloud/device/net/detail"

///设备主机详情
#define kHostDetail @"/cloud/device/host/detail"

///设备远程访问域名修改接口
#define kModifyRemote @"/cloud/device/remote/modify"

///置设备别名修改
#define kModifyAlias @"/cloud/device/alias/modify"

///设备重置
#define kResetDevice @"/cloud/device/reset"

///设备服务发现
#define kFindDevice @"239.255.255.255:1900"

///设备重启
#define kDeviceReboot @"cloud/device/reboot"

///设备关机
#define kDevicePoweroff @"cloud/device/poweroff"

///版本详情
#define kVersionDetail @"/cloud/version/detail"

///版本升级
#define kUpdateVersion @"/cloud/version/update"

///文件上传
#define kFileUpdte @"/api/v0/add"

///读取 IPFS 对象
#define kGetIPFS @"/api/v0/get"

///显示 IPFS 对象内容（不带偏移量）
#define kSetRead @"/ipfs/IPFS 文件哈希"

///显示 IPFS 对象内容
#define kCatIPFS @"/api/v0/cat"

///固定 IPFS 对象
#define kAddPin @"/api/v0/pin/add"

///移除固定 IPFS 对象
#define kRmPin @"/api/v0/pin/rm"

///更新固定 IPFS 对象
#define kUpdatePin @"/api/v0/pin/update"

///发送短信验证码
#define kSendCode @"/sms/cloud/send"

//判断用户是否存在接口（设备是否绑定该用户）
#define kExistUser @"/cloud/user/exist"

///获取 Cloud 最新版本
#define kUpgradgeCloudVersion @"/upgrade/cloud/version"

///上传升级文件
#define kUpdateUploadFile @"/upgrade/update/upload"

///升级开始
#define kStartUpdateDevice @"/upgrade/update/start"

#endif /* AppInterface_h */
