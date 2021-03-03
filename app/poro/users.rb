class Users
  def initialize
  end

  def return_data(repo_data)
    repo_data.map do |key, value|
      key[:login]
    end.uniq[0..3]
  end

end
