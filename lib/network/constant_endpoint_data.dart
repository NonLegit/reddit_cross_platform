const baseUrl = String.fromEnvironment('baseUrl',
    defaultValue: 'https://9ecc7870-252d-4e1b-bb3e-ac2336b19d3b.mock.pstmn.io');
const subredditPath = '/subreddits/{subredditName}';
const moderators = '/subreddits/{subredditName}/about/moderators';
const myprofile = '/users/me/';
var userName;
var otherprofile = '/users/${userName}/about';
//const myprofile = '/users/ZeinabMoawad/about';
