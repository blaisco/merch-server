class AdminController < ApplicationController
  def index
    @search_count = Search.count
    @search_count_today = Search.where(:created_at => Date.today..Date.today+1).count
    @game_count = Game.count
    @developer_count = Developer.count
    @platform_count = Platform.count
    @genre_count = Genre.count
  end
end
