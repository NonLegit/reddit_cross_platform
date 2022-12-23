import 'package:flutter_dotenv/flutter_dotenv.dart';

var baseUrl = dotenv.env['API'] as String;
//=========================Subreddit======================//
var subredditName;
const createCommunity = '/subreddits/';
//var getCommunity = '/subreddits/{subredditName}';
const notificationResults = '/users/notifications';
const moderationTools = '/subreddits/{subredditName}';
var subreddit = '/subreddits/${subredditName}';
//const moderators = '/subreddits/{subredditName}/about/moderators';
const mySubreddits = '/subreddits/mine';
const getPostsInHome = '/user/best/posts';
var getFlairsOfSubreddit = '/subreddits/${subredditName}/flairs';
//=======================Profile=======================//
const myprofile = '/users/me';
var userName;
var otherprofile = '/users/${userName}/about';
//const myprofile = '/users/ZeinabMoawad/about';
var myprofilePosts = '/users/${userName}/posts';
//====================Posts======================//
var createPost = '/posts';
var postId;
var votePost = 'posts/${postId}/vote';
