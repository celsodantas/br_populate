require 'net/http'
require 'json'

path = '/celsodantas/city_state_populate--BR/master/states.json'
http = Net::HTTP.new('raw.github.com', 443)
http.use_ssl = true
states = JSON.parse http.get(path).body

def capital?(city, state)
  city["name"] == state["capital"]
end

states.each do |state|
  #state_obj = State.create(:acronym => state["acronym"], :name => state["name"])

  state["cities"].each do |city|
    #City.create(:name => city, :state => state_obj, :capital => capital?(city, state))
  end
end
