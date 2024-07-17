const express = require('express');
const indexRoute = express.Router();

// Internal Imports
const authRoute = require('./userAuth');
const investementRoute = require('./investement');
const transactionRoute = require('./transaction');
const chatRoute = require('./chatBot');
const validateUserMiddleware = require('../middleware/auth');
const goalTrackRoute = require('./goalTrack');

// Mount authRoute without middleware
indexRoute.use('/auth', authRoute);

// Mount middleware to apply to routes after authRoute
indexRoute.use(validateUserMiddleware);

// Mount routes that require authentication
indexRoute.use('/investement', investementRoute);
indexRoute.use('/transaction', transactionRoute);
indexRoute.use('/chatBot', chatRoute);
indexRoute.use('/goalTrack', goalTrackRoute);

module.exports = indexRoute;
