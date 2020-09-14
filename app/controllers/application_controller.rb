class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect to "/recipes"
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :"recipes/new"
  end

  get '/recipes/:id' do
    current_recipe
    erb :'recipes/show'
  end

  post '/recipes' do
    recipe = Recipe.create(params)
    redirect to "/recipes/#{recipe.id}"
  end

  delete '/recipes/:id' do
    Recipe.find_by_id(params[:id]).destroy
    redirect to "/recipes"
  end

  get '/recipes/:id/edit' do
    current_recipe
    erb :'recipes/edit'
  end

  patch '/recipes/:id' do
    current_recipe
    @recipe.update(concise_params)
    redirect to "recipes/#{@recipe.id}"
  end


  helpers do
    
    def current_recipe
      @recipe = Recipe.find_by_id(params[:id])
    end

    def concise_params
      {name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time]}
    end

  end

end
