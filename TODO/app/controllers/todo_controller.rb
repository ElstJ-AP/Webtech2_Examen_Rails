class TodoController < ApplicationController
	def create
		@url = request.original_url

		@ingavedatum = params[:ingavedatum]
		@einddatum = params[:einddatum]
		@prioriteit = params[:prioriteit]
		@beschrijving = params[:beschrijving]
		@status = params[:status]

		@Todo = Todo.create(ingavedatum: @ingavedatum, einddatum: @einddatum, prioriteit: @prioriteit, beschrijving: @beschrijving, status: @status)
		@Todo.save

		@db = CouchRest.database(ENV['DB'])
		@response = @db.save_doc( { 'ingavedatum' => @ingavedatum, 'einddatum' => @einddatum, 'prioriteit' => @prioriteit, 'beschrijving' => @beschrijving, 'status' => @status })

		@json = { :ingavedatum => @ingavedatum, :einddatum => @einddatum, :prioriteit => @prioriteit, :beschrijving => @beschrijving, :status => @status }.to_json
	end

	def filter
		@url = request.original_url

		@prioriteit = params[:prioriteit]

		@todos = Todo.where(prioriteit: @prioriteit)
	end
end
