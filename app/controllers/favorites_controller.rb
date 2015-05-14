class FavoritesController < ApplicationController

  before_action :require_signin
  before_action :set_movie

  def create
    @user = current_user
    @like = @user.favorite_movies << @movie

    redirect_to @movie, notice: "Thanks for fav'ing!"
  end

  def destroy
    current_user.favorites.find(params[:id]).destroy
    redirect_to @movie, notice: "Sorry you unfaved it!"
  end

  private

  def set_movie
    @movie = Movie.find_by!(slug: params[:movie_id])
  end

end
