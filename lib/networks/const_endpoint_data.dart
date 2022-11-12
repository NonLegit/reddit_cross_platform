//const portNumber = String.fromEnvironment('portNumber', defaultValue: '7000');
const baseUrl = String.fromEnvironment('baseUrl',
    defaultValue: 'https://4519073e-15ed-4c6b-a7bf-feca7c0404ad.mock.pstmn.io');
const createcommunity_baseUrl2 = String.fromEnvironment('baseUrl',
<<<<<<< HEAD
    defaultValue: 'https://98f1e06d-55db-46f9-8ce9-b11c787bf763.mock.pstmn.io');
const notification_baseUrl3 = String.fromEnvironment('baseUrl',
    defaultValue: 'https://43af161f-b88c-41e0-a0e5-d93fd82c3d8f.mock.pstmn.io');
=======
    defaultValue: 'https://f08f9cea-336a-4f46-a446-fb46dd70ea6c.mock.pstmn.io');
const notification_baseUrl3 = String.fromEnvironment('baseUrl',
    defaultValue: 'https://8e216deb-cc2c-4b7b-86a7-8327d15eae0f.mock.pstmn.io');
const moderationsSetting_baseUrl4 = String.fromEnvironment('baseUrl',
    defaultValue: 'https://81de082e-bbec-471d-b892-995ab96a366f.mock.pstmn.io');
>>>>>>> origin/Eman

//=========================Subreddit======================//
var subredditName;
const createCommunity = '/subreddits';
<<<<<<< HEAD
var getCommunity = '/subreddits/${subredditName}';
const notificationResults = '/users/notifications';
//const moderationTools = '/subreddits/{subredditName}';
=======
var getCommunity = '/subreddits/{subredditName}';
const notificationResults = '/users/notifications';
const moderationTools = '/subreddits/{subredditName}';
>>>>>>> origin/Eman
//const subredditPath = '/subreddits/{subredditName}';
//const moderators = '/subreddits/{subredditName}/about/moderators';
//=======================Profile=======================//
const myprofile = '/users/me/';
var userName;
var otherprofile = '/users/${userName}/about';
//const myprofile = '/users/ZeinabMoawad/about';
