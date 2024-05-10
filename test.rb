require "http"
require "json"

api_text = "https://api.exchangerate.host/list?access_key=" + ENV.fetch("EXCHANGE_KEY")
api_info = "https://api.exchangerate.host/live?access_key=" + ENV.fetch("EXCHANGE_KEY") + "&source=AUD" # first get it for AUD

raw_api=HTTP.get(api_info)
api_parsed = JSON.parse(raw_api)
quote_hash = api_parsed.fetch("quotes") # this is where you go digging for the values 

quote_val = quote_hash.fetch("AUDAED")
pp quote_val
