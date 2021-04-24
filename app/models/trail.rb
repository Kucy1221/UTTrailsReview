require 'net/http'
require 'json'
class Trail < ApplicationRecord
    
    
    def self.new_lookup(trailName)
        params = {}
        
        @api_key = Rails.application.credentials.agrc[:server_agrc_key]
        
        #?predicate=primaryname+LIKE+'Kolob%25'
        params['predicate'] = "primaryname LIKE '#{trailName}'"
        params['apiKey'] = @api_key
        
        api_url = "https://api.mapserv.utah.gov/api/v1/search/recreation.trails_and_pathways/primaryname, id, hikedifficulty, designateduses, recreationarea"
    
        uri = URI(URI.encode(api_url))
        uri.query = URI.encode_www_form(params)
        #return(uri)
        res = Net::HTTP.get_response(uri)
        #raise AGRCGeocoderException.new("Received HTTP status #{res.code}") if res.code.to_i != 200
    
        obj = JSON.parse(res.body)
        # #raise AGRCGeocoderException.new(obj['message']) if obj['status'] != 200
        return obj
        {
          :primaryname => obj['result']['primaryname'],
          :id => obj['result']['id'],
          :hikedifficulty => obj['result']['hikedifficulty']
        }
        
        
    end    
end
