class Commit
	attr_reader :author, :commit_count
	def initialize(json_arr)
		@parsed = json_arr
		@commit_count = commit_number
		@author = commit_author
	end

	def commit_number
		@parsed.count do |commit|
			!(commit[:commit][:message].include?("Merge pull request") ||commit[:commit][:message].include?(" Merge branch 'main'") )
		end
	end

	def commit_author
		@parsed.first[:author][:login]
	end



end
