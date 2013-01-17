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
      state_obj = State.create(:acronym => state["acronym"], :name => state["name"])

      state["cities"].each do |city|
        City.create(:name => city, :state_id => state_obj.id, :capital => capital?(city, state))
      end
    end
  end
end

BRPopulate.populate
