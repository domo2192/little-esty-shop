class GithubService < ApiService
	def self.commits
		dom_endpoint = "https://api.github.com/repos/domo2192/little-esty-shop/commits?author=domo2192&per_page=100"
		ben_endpoint = "https://api.github.com/repos/domo2192/little-esty-shop/commits?author=b-enji-cmd&per_page=100"
		tommy_endpoint = "https://api.github.com/repos/domo2192/little-esty-shop/commits?author=tsnieuwen&per_page=100"
		adam_endpoint = "https://api.github.com/repos/domo2192/little-esty-shop/commits?author=Pragmaticpraxis37&per_page=100"

		ben_commits = get_data(ben_endpoint)
		dom_commits = get_data(dom_endpoint)
		tommy_commits = get_data(tommy_endpoint)
		adam_commits = get_data(adam_endpoint)

		ben_commits.map do |commit|
					binding.pry
					Commit.new(commit)
		end

		dom_commits.map do |commit|
					binding.pry
					Commit.new(commit)
		end

		tommy_commits.map do |commit|
					binding.pry
					Commit.new(commit)
		end

		adam_commits.map do |commit|
					binding.pry
					Commit.new(commit)
		end
	end

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
