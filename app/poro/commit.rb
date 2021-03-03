class Commit
	attr_reader :author
	def initialize(repo_data)
		@commit = repo_data[:commit]
		@author = repo_data[:author][:login]
	end

	def commit_number
		binding.pry
	end



end
