const jsonServer = require('json-server');
const server = jsonServer.create();
const router = jsonServer.router('database.json');
const middlewares = jsonServer.defaults();

// To handle POST, PUT and PATCH you need to use a body-parser
server.use(jsonServer.bodyParser);

// Set default middlewares (logger, static, cors and no-cache)
server.use(middlewares);

// Add custom routes before JSON Server router
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
// 		// if (req.body.name != null) {
// 		// 	req.body.id = req.body.name;
// 		// 	res.body = 'hi';
// 		// }
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
				} else
					return res.jsonp({ status: 'success', data: res.locals.data[0] });
			} else if (req.method === 'POST') {
				if (req.originalUrl.includes('/subreddits')) {
					return subredditPOST(req, res);
				}
			} else return res.locals.data;
		})()
	);
};

const subredditGET = (req, res) => {
	if (res.locals.data.length == 0)
		return res.status(404).jsonp({
			status: 'Not found',
			errorMessage: 'subreddit Not found',
		});
	else return res.locals.data;
};

const subredditPOST = (req, res) => {
	return res.jsonp({ id: res.locals.data.id });
};
