var express = require('express');
var router = express.Router();
const sql_query = require('../sql');

const { Pool } = require('pg')
/* --- V7: Using Dot Env ---
const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'postgres',
  password: '********',
  port: 5432,
})
*/
const pool = new Pool({
	connectionString: process.env.DATABASE_URL
});


/* SQL Query */
var sql_query_request = sql_query.query.query_request_unbid;
var sql_query_offer = sql_query.query.query_offer_unbid;

router.get('/', function(req, res, next) {
	pool.query(sql_query_request, (err, requests) => {
		if (err) throw err;
		pool.query(sql_query_offer, (err, offers) => {
			res.render('tasks', { title: 'Tasks', requests: requests.rows, offers: offers.rows });
		})
	});
});

module.exports = router;
