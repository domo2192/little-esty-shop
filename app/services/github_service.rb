class GithubService < ApiService
	def self.commits
		endpoint = "https://api.github.com/repos/domo2192/little-esty-shop/commits"
		commits_json = get_data(endpoint)

		commits_json.map do |commit|
					binding.pry
					Commit.new(commit)
		end
		
	end
	#author:commit[:author][:login]

	def self.users
		endpoint = "https://api.github.com/repos/domo2192/little-esty-shop/contributors"
		json = get_data(endpoint)

		json.map do |key, value|
			key[:login]
		end.uniq[0..3]
	end



	def self.repo
		endpoint = "https://api.github.com/repos/domo2192/little-esty-shop"
		json = get_data(endpoint)
		json[:name]
	end
end