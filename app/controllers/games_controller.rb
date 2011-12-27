class GamesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @title = "Games"
  	@games = Game.all
  end
  
  def show
    @game = Game.find(params[:id])
    @title = @game.name + " Merch" # replace "Merch" with something more specific (based on merch categories)
  end
  
  def find
    @title = "Search for games"
    @query = params[:q]
    if @query
      query_on = clean_query(@query)
      @result = GiantBombApi.search_games(query_on)
    end
  end
  
  # Like create, but populating a game based on predefined parameters
  def add
    result = GiantBombApi.fetch_game(params[:id])["results"]
    game = Game.create_or_update_from_hash(result)
    redirect_to edit_game_path(game), 
        :notice => "Game was successfully added."
  end
  
  def new
    @title = "New game"
    @game = Game.new(params[:game])
  end
  
  def create
    @game = Game.new(params[:game])
    
    respond_to do |format|
      if @game.save
        redirect_to(find_games_path, :notice => 'Game was successfully created.')
      else
        render :action => "new"
      end
    end
  end
  
  def edit
    @title = "Edit game"
    @game = Game.find(params[:id])
  end
  
  def update
  end
  
  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to games_path
  end
end
