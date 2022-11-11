//const portNumber = String.fromEnvironment('portNumber', defaultValue: '7000');
const baseUrl = String.fromEnvironment('baseUrl',
    defaultValue: 'https://43af161f-b88c-41e0-a0e5-d93fd82c3d8f.mock.pstmn.io');
const createCommunity = '/subreddits';
const getCommunity = '/subreddits/{subredditName}';
const notificationResults = '/users/notifications';
const moderationTools = '/subreddits/{subredditName}';
