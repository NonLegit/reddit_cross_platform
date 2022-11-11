//const portNumber = String.fromEnvironment('portNumber', defaultValue: '7000');
const baseUrl = String.fromEnvironment('baseUrl',
    defaultValue: 'https://2e4c47e0-e5b6-4ce1-9e86-7f2320924377.mock.pstmn.io');
const createCommunity = '/subreddits';
const getCommunity = '/subreddits/{subredditName}';
const notificationResults = '/users/notifications';
const moderationTools = '/subreddits/{subredditName}';
