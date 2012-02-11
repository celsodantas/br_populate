require 'net/http'
require 'json'

module BRPopulate
  def self.states
    http = Net::HTTP.new('raw.github.com', 443); http.use_ssl = true
    JSON.parse http.get('/celsodantas/city_state_populate--BR/master/states.json').body
  end

  def self.capital?(city, state)
    city["name"] == state["capital"]
  end

  def self.populate
    states.each do |state|
      state_obj = State.create(:acronym => state["acronym"], :name => state["name"])

      state["cities"].each do |city|
        City.create(:name => city, :state => state_obj, :capital => capital?(city, state))
      end
    end
  end
end

BRPopulate.populate
