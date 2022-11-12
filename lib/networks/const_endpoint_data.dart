//const portNumber = String.fromEnvironment('portNumber', defaultValue: '7000');
const baseUrl = String.fromEnvironment('baseUrl',
    defaultValue: 'https://08b575cf-d22d-4c2c-8715-3c824721fecb.mock.pstmn.io');
//=========================Subreddit======================//
var subredditName;
const createCommunity = '/subreddits';
var getCommunity = '/subreddits/${subredditName}';
const notificationResults = '/users/notifications';
//const moderationTools = '/subreddits/{subredditName}';
//const subredditPath = '/subreddits/{subredditName}';
//const moderators = '/subreddits/{subredditName}/about/moderators';
//=======================Profile=======================//
const myprofile = '/users/me/';
var userName;
var otherprofile = '/users/${userName}/about';
//const myprofile = '/users/ZeinabMoawad/about';
