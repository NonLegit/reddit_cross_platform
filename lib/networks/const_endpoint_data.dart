//const portNumber = String.fromEnvironment('portNumber', defaultValue: '7000');
const baseUrl = String.fromEnvironment('baseUrl',
    defaultValue: 'https://4519073e-15ed-4c6b-a7bf-feca7c0404ad.mock.pstmn.io');
const createcommunity_baseUrl2 = String.fromEnvironment('baseUrl',
    defaultValue: 'https://98f1e06d-55db-46f9-8ce9-b11c787bf763.mock.pstmn.io');
const notification_baseUrl3 = String.fromEnvironment('baseUrl',
    defaultValue: 'https://43af161f-b88c-41e0-a0e5-d93fd82c3d8f.mock.pstmn.io');

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
