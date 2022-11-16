//const portNumber = String.fromEnvironment('portNumber', defaultValue: '7000');
const baseUrl = String.fromEnvironment('baseUrl',
    defaultValue: 'https://4519073e-15ed-4c6b-a7bf-feca7c0404ad.mock.pstmn.io');
const createcommunity_baseUrl2 = String.fromEnvironment('baseUrl',
    defaultValue: 'https://f08f9cea-336a-4f46-a446-fb46dd70ea6c.mock.pstmn.io');
const notification_baseUrl3 = String.fromEnvironment('baseUrl',
    defaultValue: 'https://8e216deb-cc2c-4b7b-86a7-8327d15eae0f.mock.pstmn.io');
const moderationsSetting_baseUrl4 = String.fromEnvironment('baseUrl',
    defaultValue: 'https://81de082e-bbec-471d-b892-995ab96a366f.mock.pstmn.io');

//=========================Subreddit======================//
var subredditName;
const createCommunity = '/subreddits';
var getCommunity = '/subreddits/{subredditName}';
const notificationResults = '/users/notifications';
const moderationTools = '/subreddits/{subredditName}';
//const subredditPath = '/subreddits/{subredditName}';
//const moderators = '/subreddits/{subredditName}/about/moderators';
//=======================Profile=======================//
const myprofile = '/users/me/';
var userName;
var otherprofile = '/users/${userName}/about';
//const myprofile = '/users/ZeinabMoawad/about';
