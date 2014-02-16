require 'net/http'
require 'net/https' # for ruby 1.8.7
require 'json'

module BRPopulate
  def self.states
    http = Net::HTTP.new('raw.github.com', 443); http.use_ssl = true
    JSON.parse http.get('/celsodantas/br_populate/master/states.json').body
  end

  def self.capital?(city, state)
    city["name"] == state["capital"]
  end

  def self.populate
    states.each do |state|
      state_obj = States.new
      state_obj.acronym =state["acronym"]
      state_obj.name = state["name"]
      state_obj.save

      state["cities"].each do |city|
        c = Cities.new
        c.name = city
        c.state_id = state_obj.id
        c.capital = capital?(city, state)
        c.save
      end
    end
  end
end

BRPopulate::populate
