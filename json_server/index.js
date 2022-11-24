const jsonServer = require('json-server');
const server = jsonServer.create();
const router = jsonServer.router('database.json');
const middlewares = jsonServer.defaults();

// To handle POST, PUT and PATCH you need to use a body-parser
server.use(jsonServer.bodyParser);

// Set default middlewares (logger, static, cors and no-cache)
server.use(middlewares);

// Add custom routes before JSON Server router
server.get('/subreddits/mine/where', (req, res) => {
	res.jsonp({
		status: 'success',
		subreddits: [
			{
				icon: 'Icon of subreddit',
				id: '10',
				subredditName: 'r/any_name',
				membersCount: 10000,
				description: 'Wellcome to my subreddit',
			},
		],
	});
});

server.get('/users/me/', (req, res) => {
	res.redirect('/users?userName=Zeinab_maoawad');
});
server.get('/users/:userName/about', (req, res) => {
	res.redirect(`/users?userName=${req.params.userName}`);
});
server.get('/subreddits/:subredditName', (req, res) => {
	res.redirect(`/subreddits?name=${req.params.subredditName}`);
});
server.get('/users/notifications', (req, res) => {
	res.redirect(`/notifications`);
});
server.get('/users/:userName/posts', (req, res) => {
	if (req.query.sort == 'top')
		res.redirect(
			`/posts?userName=${req.params.userName}&_sort=votes&_order=desc`
		);
	else if (req.query.sort == 'hot')
		res.redirect(
			`/posts?userName=${req.params.userName}&_sort=votes,createDate&_order=desc,desc`
		);
	else
		res.redirect(
			`/posts?userName=${req.params.userName}&_sort=createDate&_order=desc`
		);
});

server.get('/subreddits/:subredditName/top', (req, res) => {
	res.redirect(
		`/posts?communityName=${req.params.subredditName}&_sort=votes&_order=desc`
	);
});

server.get('/subreddits/:subredditName/hot', (req, res) => {
	res.redirect(
		`/posts?communityName=${req.params.subredditName}&_sort=votes,createDate&_order=desc,desc`
	);
});

server.get('/subreddits/:subredditName/new', (req, res) => {
	res.redirect(
		`/posts?communityName=${req.params.subredditName}&_sort=createDate&_order=desc`
	);
});

server.post('/users/login/', (req, res) => {
	if (req.body.userName == 'Ahmed') {
		res.status(400).jsonp({
			status: 'fail',
			errorMessage: 'provide userName and password',
		});
	} else {
		res.status(200).jsonp({
			status: 'success',
			token:
				'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoyLCJ1c2VyX25hbWUiOiJBbXIxNDYiLCJmaXJzdF9uYW1lIjoiQW1yIiwibGFzdF9uYW1lIjoiQWhtZWQifSwiaWF0IjoxNjU3NTUyMDQ1fQ.FWrzHUL1_98laUJe7H2GHOXeuSadsWtqUIsk4OWCsYw',
			expiresIn: '2019-08-24T14:15:22Z',
		});
	}
});

// server.use((req, res, next) => {
// 	if (req.method === 'POST') {
// 		if (req.originalUrl.includes('/subreddits')) {
// 			req.body.displayName = 'test';
// 			req.body.icon =
// 				'https://previews.123rf.com/images/seamartini/seamartini1609/seamartini160900764/64950290-chef-toque-vector-sketch-icon-cook-cap-kitchen-cooking-hat-emblem-for-restaurant-design-element-bake.jpg';
// 			req.body.backgroundImage =
// 				'https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fassets.marthastewart.com%2Fstyles%2Fwmax-750%2Fd30%2Feasy-basic-pancakes-horiz-1022%2Feasy-basic-pancakes-horiz-1022_0.jpg%3Fitok%3DXQMZkp_j';
// 			req.body.description = 'test description';
// 			req.body.subredditLink =
// 				'https://previews.123rf.com/images/seamartini/seamartini1609/seamartini160900764/64950290-chef-toque-vector-sketch-icon-cook-cap-kitchen-cooking-hat-emblem-for-restaurant-design-element-bake.jpg';
// 			req.body.numOfMembers = 12345;
// 			req.body.numOfOnlines = 321;
// 			req.body.rules = [
// 				{
// 					title: 'no codeing',
// 					description: 'i hate coding',
// 				},
// 				{
// 					title: 'no codeing',
// 					description: 'i hate coding',
// 				},
// 				{
// 					title: 'no codeing',
// 					description: 'i hate coding',
// 				},
// 			];
// 			req.body.moderators = [
// 				{
// 					userName: 'Ali',
// 				},
// 				{
// 					userName: 'omer',
// 				},
// 				{
// 					userName: 'zeinab',
// 				},
// 				{
// 					userName: 'mazen',
// 				},
// 			];
// 			req.isJoined = true;
// 		}
// 	}
// 	// Continue to JSON Server router
// 	next();
// });

// Use default router
server.use(router);
server.listen(3000, () => {
	console.log('JSON Server is running');
});

router.render = (req, res) => {
	res.jsonp(
		(function () {
			if (req.method === 'GET') {
				if (req.originalUrl.includes('/subreddits?name=')) {
					return subredditGET(req, res);
				} else {
					return defaultGET(req, res);
				}
			} else if (req.method === 'POST') {
				if (req.originalUrl.includes('/subreddits')) {
					return subredditPOST(req, res);
				} else if (req.originalUrl.includes('/post')) {
					return postPOST(req, res);
				} else return res.locals.data;
			} else return res.locals.data;
		})()
	);
};

const defaultGET = (req, res) => {
	return {
		status: 'success',
		data: res.locals.data.length > 1 ? res.locals.data : res.locals.data[0],
	};
};

const subredditGET = (req, res) => {
	if (res.locals.data.length == 0)
		return res.status(404).jsonp({
			status: 'Not found',
			errorMessage: 'subreddit Not found',
		});
	else return defaultGET(req, res);
};

const subredditPOST = (req, res) => {
	return res.jsonp({ status: 'success', id: res.locals.data.id });
};

const postPOST = (req, res) => {
	return res.jsonp({ status: 'success', id: res.locals.data.id });
};