require 'net/http'
require 'json'
class Trail < ApplicationRecord
    
    
    def self.new_lookup(category, keywords)
        
        valid_categories = ['primaryname', 'designateduses', 'recreationarea']
        
        if not (valid_categories.include? category)
            raise "Invalid search category"
        end
        
        params = {}
        @api_key = Rails.application.credentials.agrc[:server_agrc_key]
        
        #AGRC stores primaryname as spaced capitalized words EG 'Devils Castle Trail'
        params['predicate'] = "#{category} LIKE '%#{keywords.downcase().titleize()}%'"
        params['apiKey'] = @api_key
        
        api_url = "https://api.mapserv.utah.gov/api/v1/search/recreation.trails_and_pathways/primaryname, unique_id, hikedifficulty, bikedifficulty, designateduses, recreationarea"
    
        uri = URI(URI.encode(api_url))
        uri.query = URI.encode_www_form(params)
        #puts(uri)
        res = Net::HTTP.get_response(uri)
        raise AGRCGeocoderException.new("Received HTTP status #{res.code}") if res.code.to_i != 200
    
        obj = JSON.parse(res.body)
        raise AGRCGeocoderException.new(obj['message']) if obj['status'] != 200
        puts obj
        
        trails = []
        obj['result'].each() do |trail|
            newTrail = {
              :primaryname => trail['attributes']['primaryname'],
              :id => trail['attributes']['unique_id'],
              :hikedifficulty => trail['attributes']['hikedifficulty'],
              :bikedifficulty => trail['attributes']['bikedifficulty'],
              :designateduses => trail['attributes']['designateduses'],
              :recreationarea => trail['attributes']['recreationarea']
            }
            trails.append(newTrail)
        end
        return trails
    end
    
    class AGRCGeocoderException < Exception; end
end
