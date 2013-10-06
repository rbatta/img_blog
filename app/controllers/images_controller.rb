class ImagesController < ApplicationController

	def index
	end
	
	def show
		id = params[:id]
		@image = Image.find(id)
		render 'show'
	end
end