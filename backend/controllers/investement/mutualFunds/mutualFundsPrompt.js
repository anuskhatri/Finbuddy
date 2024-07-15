const { pool } = require("../../../config/dbConfig")
const mutualFundsGpt = require("../../../utils/openAi/mutualFundsGpt")

const mutualFundsPrompt = async (req, res) => {
    try {
        const { userInput } = req.params
        const promptResult = await mutualFundsGpt(userInput)
        const gptResponse = promptResult.choices[0].message.content

        console.log("GPT Response:", gptResponse)

        // Function to extract JSON object from the GPT response
        const extractJson = (text) => {
            const jsonMatch = text.match(/{.*}/)
            if (jsonMatch) {
                return jsonMatch[0].replace(/'/g, '"') // Convert single quotes to double quotes
            }
            return null
        }

        let jsonResponse = extractJson(gptResponse)

        if (jsonResponse) {
            try {
                const queryData = JSON.parse(jsonResponse)

                // Check for irrelevant or insufficient data
                if (
                    queryData.fund_age_yr !== 'irrelevant' &&
                    queryData.risk_level !== 0 &&
                    queryData.returns_1yr !== 0
                ) {
                    let fundAgeRange
                    switch (queryData.fund_age_yr) {
                        case 'long-term':
                            fundAgeRange = [8, 10]
                            break
                        case 'mid-term':
                            fundAgeRange = [4, 8]
                            break
                        case 'short-term':
                            fundAgeRange = [1, 4]
                            break
                        default:
                            return res.status(400).send("Invalid fund_age_yr value")
                    }

                    // Define tolerance ranges
                    const riskTolerance = 1 // Adjust tolerance as needed
                    const returnsTolerance = 1 // Adjust tolerance as needed

                    const mutualData = await pool.query(
                        `SELECT * FROM mutual_funds 
                         WHERE fund_age_yr BETWEEN $1 AND $2 
                         AND risk_level BETWEEN $3 AND $4 
                         AND returns_1yr BETWEEN $5 AND $6`,
                        [
                            ...fundAgeRange,
                            queryData.risk_level - riskTolerance,
                            queryData.risk_level + riskTolerance,
                            queryData.returns_1yr - returnsTolerance,
                            queryData.returns_1yr + returnsTolerance
                        ]
                    )

                    return res.json(mutualData.rows) // Send the rows of the query result as JSON
                }
            } catch (parseError) {
                // If parsing fails, fall through to returning the message directly
                console.error("Failed to parse JSON:", parseError)
            }
        }

        // If the JSON object is irrelevant or not present, return the GPT response directly
        return res.json({ message: gptResponse })
    } catch (error) {
        console.error("Error:", error)
        res.sendStatus(500)
    }
}

module.exports = mutualFundsPrompt
