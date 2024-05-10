require "http"
require "json"

api_text = "https://api.exchangerate.host/list?access_key=" + ENV.fetch("EXCHANGE_KEY")

raw_api=HTTP.get(api_text)
api_parsed = JSON.parse(raw_api)

# go digging around for the 3 letter country codes 
api_curr = api_parsed.fetch("currencies") # this is the has that has the 3 letter codes linked to names
api_3lcountry = api_curr.keys # this is an array we can loop over!!

api_3lcountry.each do |country|
  pp country
end 

#api_quotes = api_parsed.fetch("quotes")

# first get the list of 
#pp country
<ul>
<% @api_3lcountry.each do |country| %>
  <li> country </li>
<end %>
</ul>
