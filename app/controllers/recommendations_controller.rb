class RecommendationsController < ApplicationController
	def index
		render :json => Recommendation.find(:all)
	end

	def show
		render :json => Recommendation.find_by_id(params[:id])
	end
end
