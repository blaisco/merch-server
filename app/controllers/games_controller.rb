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
  
  def new
    @title = "New game"
    @game = Game.new(params[:game])
  end
  
  def create
    @game = Game.new(params[:game])
    GiantBombApi.populate_game(@game)
    
    respond_to do |format|
      if @game.save
        format.html { redirect_to(find_games_path,
              :notice => 'Game was successfully created.') }
      else
        format.html { render :action => "new" }
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
