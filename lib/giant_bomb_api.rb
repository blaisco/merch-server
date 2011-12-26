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

module GiantBombApi

  def self.search_games(query)
    base_url = 'http://api.giantbomb.com/search/'
    params = {
      :api_key => Settings.giantbomb_api_key,
      :format => 'json',
      :resources => 'game',
      :query => query,
      :field_list => 'id,name,original_release_date'
    }
    make_request(base_url, params)
  end
  
  def self.fetch_game(fid)
    base_url = 'http://api.giantbomb.com/game/' + fid + '/'
    params = {
      :api_key => Settings.giantbomb_api_key,
      :format => 'json',
      :field_list => 'id,name,aliases,franchises,platforms,genres,developers,date_last_updated,original_release_date'
    }
    result = make_request(base_url, params)
  end
  
  def self.make_request(base_url, params)
    url = base_url + "?" + params.to_query
    Rails.logger.debug "url: " + url
    resp = Net::HTTP.get_response(URI.parse(url))
    data = resp.body
    # Rails.logger.debug "code:  " + resp.code

    # we convert the returned JSON data to native Ruby
    # data structure - a hash
    result = JSON.parse(data)

    # if the hash has "error" with a value other than "OK", we're in trouble
    if result["error"] != "OK"
      Rails.logger.error "Bad web service result: " + result.inspect
      raise "web service error"
    end
    
    result
  end
end
