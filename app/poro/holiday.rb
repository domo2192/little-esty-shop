class Holiday

  def return_name(repo_data)
    repo_data.map do |key, value|
      key[:name]
    end
  end

  def return_date(repo_data)
    repo_data.map do |key, value|
      key[:date]
    end
  end
end
