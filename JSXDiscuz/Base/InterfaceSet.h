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

#endif /* InterfaceSet_h */
