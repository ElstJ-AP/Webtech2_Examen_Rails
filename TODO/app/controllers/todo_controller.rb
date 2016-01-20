class TodoController < ApplicationController
	def create
		@url = request.original_url
		@urlExample = "http://localhost:3000/todo/create?ingavedatum=20/01/2016&einddatum=27/01/2016&prioriteit=1&beschrijving=Boter kopen&status=todo"

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
end
