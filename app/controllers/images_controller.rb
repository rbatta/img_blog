class ImagesController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]

	def index
	end
	
	def show
		id = params[:id]
		@image = Image.find(id)
		render 'show'
	end

	def create
	end
end