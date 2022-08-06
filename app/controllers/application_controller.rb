class ApplicationController < Sinatra::Base

  set :default_content_type, 'application/json'

  get '/' do
    { message: "Hello world" }.to_json
  end

  get '/games' do
    # get all the games from the database and order by title. return first 10
    games = Game.all.order(:title).limit(10)

    # return a JSON response with an array of all the game data
    games.to_json
  end

  get '/games/:id' do
    # look up the game in the database using its ID
    game = Game.find(params[:id])

    # game.to_json(include: {reviews: {include: :user}})

    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: {only: [:comments, :score], include: {
        user: {only: [:name]}}}})
  end

end
