//
//  InterfaceSet.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/17.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#ifndef InterfaceSet_h
#define InterfaceSet_h

#pragma mark - 个人中心
//验证码
#define Interface_GetRandomCode @JSXInterface
//注册
#define Interface_Register @JSXInterface
//登录
#define Interface_Login @JSXInterface
//修改头像
#define Interface_UploadHeadImg @""JSXInterface"?mod=spacecp1&ac=bindtel&doup=upavatar"
//个人信息
#define Interface_PersonalInfo @""JSXInterface"?mod=spacecp1&ac=profiler"
//个人信息(与我相关)
#define Interface_PersonalInfo2 @""JSXInterface"?mod=spacecp1&ac=follow&type=getnum"
//个人帖子信息
#define Interface_PersonalPostsInfo @""JSXInterface"?mod=spacecp1&ac=blog&type=getblog&blogid=1"
//个人信息提交
#define Interface_PersonalInfoCommit @""JSXInterface"?mod=spacecp1&ac=setmember"
//个人用户组权限
#define Interface_PersonaUserPermission @""JSXInterface"?mod=spacecp1&ac=usergroup&gid=1"
//个人中心-朋友圈
#define Interface_PersonnalFriendCircle @""JSXInterface"index.php?mod=my_userpost&type=friend&view=all"
//个人中心-我的
#define Interface_PersonnalMine @""JSXInterface"index.php?mod=my_userpost&type=friend&view=me"

#pragma mark - 社区模块
//首页列表
#define Interface_CommuityMainPage @""JSXInterface"index.php?mod=index&fcid=1"
//社区模块详情
#define Interface_CommuityMainPageDetail @""JSXInterface"index.php?mod=forumdisplay"
//最新列表
#define Interface_CommuityNewest @""JSXInterface"index.php?mod=forumdisplayallnew&fcid=1"
//推荐列表
#define Interface_CommuityRec @""JSXInterface"index.php?mod=forumdisplayallhot&fcid=1"
//图集列表
#define Interface_CommuityAlbum @""JSXInterface"index.php?mod=forumdisplayallnew&fcid=1"

#pragma mark - 小组模块
//小组列表
#define Interface_GroupMainPage @""JSXInterface"index.php?mod=group&a=index&gcid=3"
//小组模块详情
#define Interface_GroupMainPageDetail @""JSXInterface"index.php?mod=forumdisplay"
//全部小组列表(分类)
#define Interface_GroupAllList @""JSXInterface"index.php?mod=group&a=alllist"
//全部小组列表(分类列表)
#define Interface_GroupAllTypeList @""JSXInterface"index.php?mod=group&a=allfuplist"
//小组搜
#define Interface_GroupSearch @""JSXInterface"index.php?mod=group&a=search"
//小组申请加入
#define Interface_GroupJoin @""JSXInterface"index.php?mod=groupadd&a=addmember"
//小组申请退出
#define Interface_GroupLogout @""JSXInterface"index.php?mod=groupsystem&a=memberdel"
//创建小组
#define Interface_GroupCreate @""JSXInterface"index.php?mod=addthread"

#pragma mark - 首页
//首页小组模块
#define Interface_FirstPageGroupMode @""JSXInterface"index.php?mod=index_lanmu&ac=group&gcid=3"
//首页社区模块
#define Interface_FirstPageCommunityMode @""JSXInterface"index.php?mod=index_lanmu&ac=forum&fcid=1"
//首页帖子模块
#define Interface_FirstPagePostsMode @""JSXInterface"index.php?mod=index_forumlist&fcid=1"

#pragma mark - 帖子详情
//小组列表
#define Interface_PostsDetail @""JSXInterface"index.php?mod=group&a=third"
//回帖提交
#define Interface_PostsReply @""JSXInterface"index.php?mod=addreply"
//帖子点赞
#define Interface_PostsLike @""JSXInterface"index.php?mod=group&a=dzan"
//是否收藏贴子
#define Interface_PostsHasCollection @""JSXInterface"index.php?mod=group&a=collectsun"
//收藏贴子
#define Interface_PostsCollection @""JSXInterface"index.php?mod=group&a=collect"
//取消收藏贴子
#define Interface_PostsDeCollection @""JSXInterface"index.php?mod=group&a=delcollect"
//是否已阅帖子
#define Interface_PostsHasRead @""JSXInterface"index.php?mod=group&a=yysun"
//已阅帖子
#define Interface_PostsRead @""JSXInterface"index.php?mod=addreply"

#pragma mark - 发现
//帖子搜索
#define Interface_DiscoverySearch @""JSXInterface"index.php?mod=index_forumlist&fcid=1"
//朋友搜索
#define Interface_DiscoverySearchFriend @""JSXInterface"index.php?mod=friend&op=search"

#endif /* InterfaceSet_h */
