class ImagesController < ApplicationController
	def show
		id = params[:id]
		@image = Image.find(id)
		render 'show'
	end
end