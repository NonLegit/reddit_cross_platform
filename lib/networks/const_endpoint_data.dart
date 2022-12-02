//const portNumber = String.fromEnvironment('portNumber', defaultValue: '7000');
import 'package:post/other_profile/models/others_profile_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

var baseUrl = String.fromEnvironment('baseUrl',
    defaultValue: dotenv.env['API'] as String);

//=========================Subreddit======================//
var subredditName;
const createCommunity = '/subreddits';
//var getCommunity = '/subreddits/{subredditName}';
const notificationResults = '/users/notifications';
const moderationTools = '/subreddits/{subredditName}';
var subreddit = '/subreddits/${subredditName}';
//const moderators = '/subreddits/{subredditName}/about/moderators';
//=======================Profile=======================//
const myprofile = '/users/me/';
var userName;
var otherprofile = '/users/${userName}/about';
//const myprofile = '/users/ZeinabMoawad/about';
//====================Posts======================//
var createPost = '/posts';
