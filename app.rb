require "sinatra"
require "sinatra/reloader"
require "http"
require "json"
require "better_errors"


# the actual webpage
get("/") do
  # parsing the API itself
  api_text = "https://api.exchangerate.host/list?access_key=" + ENV.fetch("EXCHANGE_KEY")

  raw_api=HTTP.get(api_text)
  api_parsed = JSON.parse(raw_api)

  # go digging around for the 3 letter country codes 
  api_curr = api_parsed.fetch("currencies") # this is the has that has the 3 letter codes linked to names
  @api_3lcountry = api_curr.keys # this is an array we can loop over!!

  erb(:home)
end

get("/:country") do 
  @original_currency = params.fetch("country")

  api_text = "https://api.exchangerate.host/list?access_key=" + ENV.fetch("EXCHANGE_KEY")

  raw_api=HTTP.get(api_text)
  api_parsed = JSON.parse(raw_api)

  # go digging around for the 3 letter country codes 
  api_curr = api_parsed.fetch("currencies") # this is the has that has the 3 letter codes linked to names
  @api_3lcountry = api_curr.keys # this is an array we can loop over!!

  erb(:country)
end 

get("/:country/:conversion") do 
  @original_currency = params.fetch("country")
  @conversion_currency = params.fetch("conversion")

  total = @original_currency + @conversion_currency

  # get the api 
  api_url = "https://api.exchangerate.host/convert?access_key=#{ENV.fetch("EXCHANGE_KEY")}&from=#{@original_currency}&to=#{@conversion_currency}&amount=1"

  raw_api_info=HTTP.get(api_url)
  api_parsed_info = JSON.parse(raw_api_info)
  @quote_val = api_parsed_info.fetch("result")

  erb(:conversion)
end 
