import 'package:flutter_dotenv/flutter_dotenv.dart';

var baseUrl = dotenv.env['API'] as String;
//=========================Subreddit======================//
var subredditName;
const createCommunity = '/subreddits/';
const notificationResults = '/users/notifications';
const moderationTools = '/subreddits/{subredditName}';
var subreddit = '/subreddits/${subredditName}';
const mySubreddits = '/subreddits/mine';
const getPostsInHome = '/user/best/posts';
var getFlairsOfSubreddit = '/subreddits/${subredditName}/flairs';
//=======================Profile=======================//
const myprofile = '/users/me';
var userName;
var otherprofile = '/users/${userName}/about';
var myprofilePosts = '/users/${userName}/posts';
//====================Posts======================//
var createPost = '/posts';
var postId;
var votePost = 'posts/${postId}/vote';
