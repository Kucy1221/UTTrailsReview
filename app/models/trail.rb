require 'net/http'
require 'json'
class Trail < ApplicationRecord
    
    has_many :reviews
    
    def self.new_lookup(searchparams)
        
        valid_categories = ['primaryname', 'designateduses', 'recreationarea']
        
        searchstring = ""
        valid_categories.each do |category|
            if searchparams[category].length() > 0
                if searchstring.length() > 0
                    searchstring += " AND "
                end
                searchstring += "#{category} LIKE '%#{searchparams[category].downcase().titleize()}%'"
            end
        end
        #if not (valid_categories.include? category)
        #    raise "Invalid search category"
        #end
        
        params = {}
        @api_key = Rails.application.credentials.agrc[:server_agrc_key]
        
        #AGRC stores primaryname as spaced capitalized words EG 'Devils Castle Trail'
        params['predicate'] = searchstring
        params['apiKey'] = @api_key
        
        api_url = "https://api.mapserv.utah.gov/api/v1/search/recreation.trails_and_pathways/primaryname, xid, hikedifficulty, bikedifficulty, designateduses, recreationarea"
    
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
              :xid => trail['attributes']['xid'],
              :hikedifficulty => trail['attributes']['hikedifficulty'],
              :bikedifficulty => trail['attributes']['bikedifficulty'],
              :designateduses => trail['attributes']['designateduses'],
              :recreationarea => trail['attributes']['recreationarea']
            }
            trails.append(newTrail)
        end

        #there are tons of copies of the same trails in the API database. Filter them out here
        uniqueTrails = []
        trails.each() do |trail|
            unique = true
            uniqueTrails.each() do |uniqueTrail|
                if trail[:primaryname] == uniqueTrail[:primaryname] && trail[:hikedifficulty] == uniqueTrail[:hikedifficulty] && trail[:bikedifficulty] == uniqueTrail[:bikedifficulty] && trail[:designateduses] == uniqueTrail[:designateduses] && trail[:recreationarea] == uniqueTrail[:recreationarea]
                    unique = false
                    break
                end
            end
            if unique
                uniqueTrails.append(trail)
            end
        end

        return uniqueTrails
    end
    
    class AGRCGeocoderException < Exception; end
end
