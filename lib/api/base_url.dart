// const serviceUrl = 'http://hnt.hnjiayou.cn/api/v1'; // dev
const serviceUrl = 'http://hnt.hnjiayou.cn/api'; //pro


const servicePath = {
  ///注册
  "register":"/account/register",
  ///发送短信
  "sendSms":"/account/sendSms",
  ///账号登陆
  "accountLogin":"/account/accountLogin",
  ///短信登陆
  "smsLogin":"/account/smsLogin",
  ///用户信息
  "userInfo":"/user/userInfo",
  ///创建房间
  "addRoom":"/room/addRoom",
  ///获取报名费配置
  "getEnrollConf":"/config/getEnrollConf",
  ///获取可加入房间列表
  "roomAllList":"/room/roomAllList",
  ///用户绑定游戏账户
  "addUserBind":"/user_bind/addUserBind",
  ///用户绑定的账户列表
  "roleList":"/user_bind/roleList",
  ///用户解绑
  "delRole":"/user_bind/del_role",
  ///游戏段位列表
  "getRankList":"/user_bind/getRankList",
};