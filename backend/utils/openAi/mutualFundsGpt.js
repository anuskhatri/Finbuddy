const { openAi } = require("../../config/openAIConfig")

const mutualFundsGpt = async (prompt) => {
  const result = await openAi.chat.completions.create({
    messages: [
      { "role": "system", "content": "Your objective is to intelligently convert natural language queries of users into the three variables: fund_age_yr (duration of mutual funds: Short Term [1-3 yrs], Mid Term [4-7 yrs], Long Term [8-10 yrs]), risk_level (Low Risk [1-2], Medium Risk [3-4], High Risk [5-6]), and returns_1yr (calculated based on fund_age_yr, risk_level, user bank balance, and pending loan).\n\nOutput the following JSON format strictly based on relevant queries:\n{\n  \"fund_age_yr\": <integer>,\n  \"risk_level\": <integer>,\n  \"returns_1yr\": <float>\n}\n\nFor any irrelevant queries, or when unable to determine relevant values, or when the user query is unclear, or there is insufficient data to answer or any random words like hey ,hi etc..., output all values as 0. If any response contains values other than JSON, it will result in user disappointment. Ensure responses are accurate and relevant." },
      
      { "role": "user", "content": "I'm looking to invest in mutual funds with a moderate risk level. I have a bank balance of ₹20,000 and a pending loan of ₹5,000. What type of mutual fund should I consider for a 5-year investment?" },
      { "role": "assistant", "content": "{'fund_age_yr': 'mid-term', 'risk_level': 3, 'returns_1yr': 8}" },

      { "role": "user", "content": "I want to retire early and I'm okay with taking higher risks. I have ₹1,000,000 saved up, but I still owe ₹300,000 in loans. Which mutual fund should I choose for investing over the next 15 years?" },
      { "role": "assistant", "content": "{'fund_age_yr': 'long-term', 'risk_level': 5, 'returns_1yr': 10}" },

      { "role": "user", "content": "retirement" },
      { "role": "assistant", "content": "{'fund_age_yr': 'long-term', 'risk_level': 5, 'returns_1yr': 10}" },

      { "role": "user", "content": "How to invest If I want to buy a car" },
      { "role": "assistant", "content": "{'fund_age_yr': 'short-term', 'risk_level': 2, 'returns_1yr': 6}" },

      { "role": "user", "content": "I have ₹50,000 and I want to invest in something with low risk. What mutual fund options do I have?" },
      { "role": "assistant", "content": "{'fund_age_yr': 'short-term', 'risk_level': 1, 'returns_1yr': 4}" },

      { "role": "user", "content": "I need to save for my child's education, which will be needed in 10 years. I prefer a balanced risk approach. What should I do?" },
      { "role": "assistant", "content": "{'fund_age_yr': 'long-term', 'risk_level': 3, 'returns_1yr': 7}" },

      { "role": "user", "content": "I have ₹200,000 and no debts. I'm aiming for high returns over the next 3 years and I'm willing to take higher risks. What should I invest in?" },
      { "role": "assistant", "content": "{'fund_age_yr': 'short-term', 'risk_level': 4, 'returns_1yr': 9}" },

      { "role": "user", "content": "I want to create an emergency fund. How should I invest ₹30,000 to ensure it grows but stays accessible?" },
      { "role": "assistant", "content": "{'fund_age_yr': 'short-term', 'risk_level': 1, 'returns_1yr': 5}" },

      { "role": "user", "content": "What's a good mutual fund investment if I want to save for a vacation in 2 years? I prefer low risk." },
      { "role": "assistant", "content": "{'fund_age_yr': 'short-term', 'risk_level': 2, 'returns_1yr': 6}" },

      { "role": "user", "content": "How should I invest if I want to accumulate wealth over the next 20 years with moderate risk?" },
      { "role": "assistant", "content": "{'fund_age_yr': 'long-term', 'risk_level': 3, 'returns_1yr': 8}" },

      { "role": "user", "content": `${prompt}` }
    ],
    max_tokens: 40
  })
  return result
}
module.exports = mutualFundsGpt