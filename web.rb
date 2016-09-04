require 'sinatra/base'
require 'http'

module SlackGoogleBot
  class Web < Sinatra::Base
    get '/' do
      'Slack integration with Google, https://github.com/dblock/slack-google-bot.'
    end
	get '/test' do
	  a = HTTP.get("https://www.googleapis.com/customsearch/v1", params: {
        q: 'Bard',
        key: ENV['GOOGLE_API_KEY'],
        cx: ENV['GOOGLE_CSE_ID']
      })
	  return "Test result: " + a
	end
  end
end
