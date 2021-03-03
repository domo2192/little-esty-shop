class Commit
	def initialize(repo_data)
		@commit = repo_data[:commit]
		@author = repo_data[:author][:login]
		@commit_number = repo_data[]
	end

	def commit
		binding.pry
	end

	def author
		
	end

	def commit_number
		
	end



end
