class PagesController < ApplicationController
  
  def home
  end

  def search
  	@search = params[:search]
  	@results = SearchMovies.new(@search).perform
  	if @results[0] == nil
  		flash[:danger] = "yo la recherche n'a rien donné"
  		redirect_to root_path
  	else
  		render "search"
  	end
  end

end
