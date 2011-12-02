# == Schema Information
#
# Table name: sources
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  type       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'json'
require 'net/http'

class GiantBombApi

  def self.search_games(query)
    base_url = 'http://api.giantbomb.com/search/'
    params = {
      :api_key => SETTINGS[:giantbomb_api_key],
      :format => 'json',
      :resources => 'game',
      :query => query,
      :field_list => 'id,name,original_release_date'
    }
    make_request(base_url, params)
  end
  
  def self.fetch_game(uid)
    base_url = 'http://api.giantbomb.com/game/' + uid + '/'
    params = {
      :api_key => SETTINGS[:giantbomb_api_key],
      :format => 'json',
      :field_list => 'id,name,aliases,platforms,genres,developers,date_last_updated,original_release_date'
    }
    make_request(base_url, params)
  end
  
  def self.populate_game(game)
    api = GiantBombApi.first
    junction = api.junctions.find_or_initialize_by_uid_and_updateable_type(game.junction_uid, 'Game')
    result = GiantBombApi.fetch_game(game.junction_uid)
    result = result["results"]
    if junction.new_record?
      game.junction = junction
      api.categories_from_hash(game, "Developer", result["developers"])
      api.categories_from_hash(game, "Platform", result["platforms"])
      api.categories_from_hash(game, "Genre", result["genres"])
    end
    game
  end
  
  def self.make_request(base_url, params)
    url = base_url + "?" + params.to_query
    logger.debug "url:  " + url
    resp = Net::HTTP.get_response(URI.parse(url))
    data = resp.body
    # logger.debug "code:  " + resp.code

    # we convert the returned JSON data to native Ruby
    # data structure - a hash
    result = JSON.parse(data)

    # if the hash has "error" with a value other than "OK", we're in trouble
    if result["error"] != "OK"
      logger.error "Bad web service result: " + result.inspect
      raise "web service error"
    end
    
    result
  end
  
  ##############################################################################
  # Game-related stuff
  
  # Add categories (developers, genres, or platforms) for a game
  def categories_from_hash(game, class_name, result_category)
    result_category.each do |cat|
      junction = junctions.find_by_uid_and_updateable_type(cat["id"].to_s, class_name)
      if junction
        category = junction.updateable
        category.games << game unless category.games.include?(game)
        category.save
      else
        junction = junctions.build({
          :uid => cat["id"].to_s
        })
        category = Kernel.const_get(class_name).new({
          :name => cat["name"]
        })
        category.games << game unless category.games.include?(game)
        category.save
        junction.updateable = category
        junction.save 
      end
    end
    game
  end
end
