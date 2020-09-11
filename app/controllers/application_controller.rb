class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end



get "/recipes" do
  @recipes = Recipe.all

  erb :index
end

get '/recipes/new'
  recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients])

end

get '/recipes/:id'
  
end

get '/recipes/:id/edit'

end
