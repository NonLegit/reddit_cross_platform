//imports
const jsonServer = require('json-server');
const jwt = require('jsonwebtoken');
var fs = require('fs');

/////////////////////////////////////////////////////////////////////////////////////////////////

//configrations
const server = jsonServer.create();
const router = jsonServer.router('database.json');
const middlewares = jsonServer.defaults();
server.use(jsonServer.bodyParser);
server.use(middlewares);

/////////////////////////////////////////////////////////////////////////////////////////////////

//endpoints flags

var isAvailabilityCheck = false;
var is_users_userName_posts = false;
var is_subreddits_subredditName_top = false;
var is_subreddits_subredditName_flairs = false;
/////////////////////////////////////////////////////////////////////////////////////////////////

//helpers
function writeInDB(location, data) {
	fs.readFile('database.json', 'utf8', function readFileCallback(err, db) {
		if (err) {
			console.log(err);
		} else {
			obj = JSON.parse(db); //now it an object
			obj[location].push(data); //add some data
			json = JSON.stringify(obj); //convert it back to json
			fs.writeFile('database.json', json, 'utf8', function (err) {
				if (err) throw err;
				console.log('db updated');
			}); // write it back
		}
	});
}

function generateJWT(user) {
	return jwt.sign({ userId: user }, 'AmrMadeThat', { expiresIn: '3d' });
}

function Authenticate(req, res, next) {
	try {
		const tokenHeader = req.headers.authorization.split('Bearer ')[1];
		console.log(tokenHeader);
		const decoded = jwt.verify(tokenHeader, 'AmrMadeThat');
		console.log(decoded);
		req.user = decoded;
		next();
	} catch (err) {
		res.status(401).jsonp({
			status: 'fail',
			errorMessage: 'not authorized',
		});
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////

// Get Requests
server.get('/subreddits/mine/where', Authenticate, (req, res) => {
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

server.get('/users/username_available', (req, res) => {
	if (req.query.userName == undefined)
		res.jsonp({
			status: 'fail',
			message: 'userName query paramater is required',
		});
	else {
		isAvailabilityCheck = true;
		res.redirect(`/users?userName=${req.query.userName}`);
	}
});

server.get('/users/me/', Authenticate, (req, res) => {
	console.log(req.user.userId);
	res.redirect(`/users/${req.user.userId}`);
});
server.get('/users/:userName/about', (req, res) => {
	res.redirect(`/users?userName=${req.params.userName}`);
});
server.get('/subreddits/:subredditName', (req, res) => {
	console.log(req);
	res.redirect(`/subreddits?name=${req.params.subredditName}`);
});
server.get('/users/notifications', (req, res) => {
	res.redirect(`/notifications`);
});
server.get('/users/:userName/posts', (req, res) => {
	is_users_userName_posts = true;
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
			`/posts?author.name=${req.params.userName}&_sort=createDate&_order=desc`
		);
});

server.get('/subreddits/:subredditName/top', (req, res) => {
	is_subreddits_subredditName_top = true;
	res.redirect(
		`/posts?communityName=${req.params.subredditName}&_sort=votes&_order=desc`
	);
});

server.get('/subreddits/:subredditName/hot', (req, res) => {
	is_subreddits_subredditName_top = true;
	res.redirect(
		`/posts?communityName=${req.params.subredditName}&_sort=votes,createDate&_order=desc,desc`
	);
});

server.get('/subreddits/:subredditName/new', (req, res) => {
	is_subreddits_subredditName_top = true;
	res.redirect(
		`/posts?communityName=${req.params.subredditName}&_sort=createDate&_order=desc`
	);
});
server.get('/subreddits/mine/subscriber', (req, res) => {
	res.redirect(`/subreddits_subscriber`);
});
server.get('/subreddits/mine/moderator', (req, res) => {
	res.redirect(`/subreddits_moderator`);
});

server.get('/subreddits/mine/subscriber', (req, res) => {
	res.redirect(`/subreddits_subscriber`);
});
server.get('/subreddits/mine/moderator', (req, res) => {
	res.redirect(`/subreddits_moderator`);
});

server.get('/users/best', (req, res) => {
	is_subreddits_subredditName_top = true;
	res.redirect(`/posts`);
});

server.get('/subreddits/:subredditName/flairs', (req, res) => {
	is_subreddits_subredditName_flairs = true;
	console.log(req.params.subredditName);
	res.redirect('/flairs');
});

/////////////////////////////////////////////////////////////////////////////////////////////////

// Post Requests

server.post('/subreddits', (req, res) => {
	console.log(req);
});

server.post('/users/login/', (req, res) => {
	if (req.body.userName == 'Ahmed') {
		res.status(400).jsonp({
			status: 'fail',
			errorMessage: 'provide userName and password',
		});
	} else {
		fs.readFile('database.json', 'utf8', function readFileCallback(err, db) {
			if (err) {
				console.log(err);
			} else {
				obj = JSON.parse(db); //now it an object

				var today = new Date();
				var add3 = new Date();
				add3.setDate(today.getDate() + 3);

				res.status(200).jsonp({
					status: 'success',
					token: generateJWT(
						Object.values(obj['users']).find((obj) => {
							return obj.userName == req.body.userName;
						}).id
					),
					expiresIn: add3.toISOString(),
				});
			}
		});
	}
});
server.post('/users/signup', (req, res) => {
	req.body.id = new Date();
	req.body.profilePicture =
		'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png';
	req.body.profileBackground =
		'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/items/270010/4bdbd33eb075f0c7d6d4d3e8a4065aa336b15b73.jpg';
	req.body.lastUpdatedPassword = new Date().toISOString();
	req.body.adultContent = false;
	req.body.autoplayMedia = true;
	req.body.canbeFollowed = true;
	req.body.followersCount = 0;
	req.body.friendsCount = 0;
	req.body.accountActivated = true;
	req.body.gender = 'male';
	req.body.displayName = req.body.userName;
	req.body.postKarma = 1;
	req.body.commentKarma = 1;
	req.body.isFollowed = true;
	req.body.createdAt = new Date().toISOString();
	req.body.description = 'info';
	var today = new Date();
	var add3 = new Date();
	add3.setDate(today.getDate() + 3);
	writeInDB('users', req.body);
	res.status(201).jsonp({
		status: 'success',
		token: generateJWT(req.body.id),
		expiresIn: add3.toISOString(),
	});
});

server.post(
	'/subreddits/:subredditName/moderators/:moderatorName',
	(req, res) => {
		fs.readFile('database.json', 'utf8', function readFileCallback(err, db) {
			if (err) {
				console.log(err);
			} else {
				obj = JSON.parse(db); //now it an object
				try {
					Object.values(obj['subreddits'])
						.find((obj) => {
							return obj.name == req.params.subredditName;
						})
						.moderators.push({
							userName: req.params.moderatorName,
							joiningDate: '2019-08-24T14:15:22Z',
							profilePicture: 'not used',
							moderatorPermissions: {
								all: true,
								access: true,
								config: true,
								flair: true,
								posts: true,
							},
						});
				} catch (err) {
					console.log(err);
					res
						.status(404)
						.jsonp({
							status: 'fail',
							errorMessage: 'subreddit not found',
						})
						.send();
				}
				json = JSON.stringify(obj); //convert it back to json
				fs.writeFile('database.json', json, 'utf8', function (err) {
					if (err) throw err;
					console.log('db updated');
				}); // write it back
			}
			res.status(200).send();
		});
	}
);

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

/////////////////////////////////////////////////////////////////////////////////////////////////

//use Router

server.use(router);

// Start Server

server.listen(3000, () => {
	console.log('JSON Server is running');
});

/////////////////////////////////////////////////////////////////////////////////////////////////

//Change response after json
router.render = (req, res) => {
	res.jsonp(
		(function () {
			if (req.method === 'GET') {
				if (req.originalUrl.includes('/subreddits?name=')) {
					return subredditGET(req, res);
				} else if (isAvailabilityCheck) {
					return username_available(req, res);
				} else if (is_users_userName_posts) {
					is_users_userName_posts = false;
					return getPOST(req, res);
				} else if (is_subreddits_subredditName_top) {
					is_users_userName_posts = false;
					return getDataPOST(req, res);
				} else if (is_subreddits_subredditName_flairs) {
					is_subreddits_subredditName_flairs = false;
					return getFlairs(req, res);
				} else {
					return defaultGET(req, res);
				}
			} else if (req.method === 'POST') {
				if (req.originalUrl.includes('/subreddits')) {
					return subredditPOST(req, res);
				} else if (req.originalUrl.includes('/post')) {
					return postPOST(req, res);
				} else if (req.originalUrl.includes('/users/singnup')) {
					return signup(req, res);
				} else return res.locals.data;
			} else return res.locals.data;
		})()
	);
};

/////////////////////////////////////////////////////////////////////////////////////////////////

// Response Functions

const defaultGET = (req, res) => {
	return {
		status: 'success',
		data: Array.isArray(res.locals.data)
			? res.locals.data.length > 1
				? res.locals.data
				: res.locals.data[0]
			: res.locals.data,
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
const getPOST = (req, res) => {
	data = res.locals.data;
	return {
		status: 'success',
		posts: Array.isArray(data) ? data : [data],
	};
};

const getDataPOST = (req, res) => {
	data = res.locals.data;
	return {
		status: 'success',
		data: Array.isArray(data) ? data : [data],
	};
};

const getFlairs = (req, res) => {
	data = res.locals.data;
	return {
		status: 'success',
		data: Array.isArray(data) ? data : [data],
	};
};

const signup = (req, res) => {
	return res.jsonp({ token: generateJWT(req.body.userName) });
};

const username_available = (req, res) => {
	isAvailabilityCheck = false;
	if (res.locals.data == 0)
		return res.jsonp({
			available: true,
		});
	return res.jsonp({
		available: false,
	});
};
