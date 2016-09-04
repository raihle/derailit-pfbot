require 'http'

class PfBot < SlackRubyBot::Bot
	match(/^(?<bot>\w*)\s(?<expression>.*)$/) do |client, data, match|
		expression = match['expression'].strip
		
		results = HTTP.get("https://www.googleapis.com/customsearch/v1", params: {
			q: expression,
			key: ENV['GOOGLE_API_KEY'],
			cx: ENV['GOOGLE_CSE_ID']
		})
		parsed = JSON.parse results
		if parsed.nil?
			message = results
		else
			result = parsed['items'].first
			if result.nil?
				message = "No search results for `#{expression}`"
			else
				message = result['title'] + "\n" + result['link'] + "\n" + "```" + result['snippet'] + "```"
			end
		end
		send_message client, data.channel, message
	end
end

PfBot.run

