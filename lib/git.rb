require 'octokit'

class Git
  def self.client
    @client ||= Octokit::Client.new(:access_token => ENV.fetch("GITHUB_ACCESS_TOKEN"))
  end

  def self.create_repo(repo_name, username)
    repo = client.create_repository(repo_name)
    client.add_collaborator(repo.id, username)
    return repo
  end

  def self.delete_repo(repo_name)
    client.delete_repository(repo_name)
  end
end