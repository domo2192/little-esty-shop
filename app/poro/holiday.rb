class Holiday

  def return_data(repo_data)
    repo_data.map do |key, value|
      key[:name]
    end.uniq[0..2]
  end
end
