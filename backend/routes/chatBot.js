const {Router}=require('express')
const chatPrompt = require('../controllers/chatBot/chat')
const TransactionPrompt = require('../controllers/chatBot/transaction')
const loanPrompt = require('../controllers/chatBot/loan')
const investementPrompt = require('../controllers/chatBot/investement')
const portfolioSummary = require('../controllers/chatBot/portfolioSummary')
const chatRoute=Router()

chatRoute.get('/chat/:userInput',chatPrompt)
chatRoute.get('/transaction/:userInput',TransactionPrompt)
chatRoute.get('/loans/:userInput',loanPrompt)
chatRoute.get('/investment/:userInput',investementPrompt)
chatRoute.get('/portfolioSummary/',portfolioSummary)

module.exports=chatRoute