require "sinatra"
require "sinatra/reloader"
require "http"
require "json"
require "better_errors"

# parsing the API itself
api_text = "https://api.exchangerate.host/list?access_key=" + ENV.fetch("EXCHANGE_KEY")

raw_api=HTTP.get(api_text)
api_parsed = JSON.parse(raw_api)

# go digging around for the 3 letter country codes 
api_curr = api_parsed.fetch("currencies") # this is the has that has the 3 letter codes linked to names


# the actual webpage
get("/") do
  @api_3lcountry = api_curr.keys # this is an array we can loop over!!

  erb(:home)
end

get("/:country") do 
  @original_currency = params.fetch("country")
  erb(:country)
end 
