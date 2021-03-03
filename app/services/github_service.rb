class GithubService < ApiService
	def self.commits
		breakdown = Hash.new { |hash, key| hash[key] = [] }

		dom_endpoint = "https://api.github.com/repos/domo2192/little-esty-shop/commits?author=domo2192&per_page=100"
		ben_endpoint = "https://api.github.com/repos/domo2192/little-esty-shop/commits?author=b-enji-cmd&per_page=100"
		tommy_endpoint = "https://api.github.com/repos/domo2192/little-esty-shop/commits?author=tsnieuwen&per_page=100"
		adam_endpoint = "https://api.github.com/repos/domo2192/little-esty-shop/commits?author=Pragmaticpraxis37&per_page=100"

		ben_commits = get_data(ben_endpoint)
		dom_commits = get_data(dom_endpoint)
		tommy_commits = get_data(tommy_endpoint)
		adam_commits = get_data(adam_endpoint)


		breakdown["domo2192"] = Commit.new(dom_commits)
		breakdown["b-enji-cmd"] = Commit.new(ben_commits)
		breakdown["tsnieuwen"] = Commit.new(tommy_commits)
		breakdown["Pragmaticpraxis37"] = Commit.new(adam_commits)
    breakdown 
	end

	def self.users
		endpoint = "https://api.github.com/repos/domo2192/little-esty-shop/contributors"
		json = get_data(endpoint)

		user = Users.new
		user.return_data(json)
	end



	def self.repo
		endpoint = "https://api.github.com/repos/domo2192/little-esty-shop"
		json = get_data(endpoint)
		json[:name]
	end

	def self.prs
		pr_endpoint = "https://api.github.com/repos/domo2192/little-esty-shop/pulls?state=closed"
		pr_json = get_data(pr_endpoint)
		pr_json.first[:number]
	end
end
