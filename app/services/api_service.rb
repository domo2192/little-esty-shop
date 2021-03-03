class ApiService
	def self.get_data(endpoint)
		response = Faraday.get(endpoint)do |req|
			req.headers['Authorization'] = "token #{ENV['GITHUB_TOKEN']}"
		end
		data = response.body
		JSON.parse(data, symbolize_names: true)
	end
end