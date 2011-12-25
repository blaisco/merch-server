class AdminController < ApplicationController
  before_filter :authenticate_user!

  def index
    @search_count_today = Search.where(:created_at => Date.today..Date.today+1).count
  end
end
