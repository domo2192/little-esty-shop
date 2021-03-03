class Github
	def initialize(repo_data)
		@commit = repo_data[:commit]
		require "pry"; binding.pry
	end

	def commit
		binding.pry
	end

end
