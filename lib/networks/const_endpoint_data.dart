//const portNumber = String.fromEnvironment('portNumber', defaultValue: '7000');
const baseUrl = String.fromEnvironment('baseUrl',
    defaultValue: 'https://4519073e-15ed-4c6b-a7bf-feca7c0404ad.mock.pstmn.io');
const createcommunity_baseUrl2 = String.fromEnvironment('baseUrl',
    defaultValue: 'https://0842618a-8a79-41dd-9203-5bb88803cd97.mock.pstmn.io');
const notification_baseUrl3 = String.fromEnvironment('baseUrl',
    defaultValue: 'https://8e216deb-cc2c-4b7b-86a7-8327d15eae0f.mock.pstmn.io');
const moderationsSetting_baseUrl4 = String.fromEnvironment('baseUrl',
    defaultValue: 'https://81de082e-bbec-471d-b892-995ab96a366f.mock.pstmn.io');

//=========================Subreddit======================//
var subredditName;
const createCommunity = '/subreddits';
//var getCommunity = '/subreddits';
const notificationResults = '/users/notifications';
const moderationTools = '/subreddits/{subredditName}';
//const subredditPath = '/subreddits/{subredditName}';
//const moderators = '/subreddits/{subredditName}/about/moderators';
//=======================Profile=======================//
const myprofile = '/users/me/';
var userName;
var otherprofile = '/users/${userName}/about';
//const myprofile = '/users/ZeinabMoawad/about';
