class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect '/recipes'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    @recipe = Recipe.new(
      name: params[:name],
      ingredients: params[:ingredients],
      cook_time: params[:cook_time]
    ).tap do |recipe|
      @recipe = recipe.save
    redirect to "/recipes/#{recipe.id}"
    end
  end
  
  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find(params[:id]).each do |recipe|
      recipe.update(
        name: params[:name],
        ingredients: params[:ingredients],
        cook_time: params[:cook_time]
      )
      @recipe.save
      redirect to "/recipes/#{recipe.id}"
    end
  end
    # @recipe = Recipe.find_by_id(params[:id])
    # @recipe.name
    # @recipe.ingredients
    # @recipe.cook_time
    # @recipe.save
    # redirect to "/recipes/#{@recipe.id}"

  delete '/recipes/:id' do
    Recipe.find(params[:id]).destroy
    redirect '/recipes'
  end




end
