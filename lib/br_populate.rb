module BRPopulate
  
  class StateAndCity
    class << self

      def populate
        states.each do |state|
          p state["name"]
          state_obj = State.create(:acronym => state["acronym"], :name => state["name"])

          state["cities"].each do |city|
            City.create(:name => city, :state => state_obj, :capital => capital?(city, state))
          end
        end
      end
      
      
      private
      
      def states
        get_json("https://raw.github.com/celsodantas/city_state_populate--BR/master/states.json")
      end
      
      def get_json(url)
        uri  = URI(url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.start {
          http.request_get(uri.path) {|res|
            return JSON.parse(res.body)
          }
        }
      end
      
      def capital?(city, state)
        city["name"] == state["capital"]
      end
      
    end
  end
end