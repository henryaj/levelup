require 'git'
require 'securerandom'

class Review < ApplicationRecord
  belongs_to :user

  before_create :generate_repo_slug, :initialize_github_repo
  before_destroy :delete_github_repo
  
  private
  def initialize_github_repo
    Git.create_repo(git_repo, user.github_username)
  end

  def delete_github_repo
    Git.delete_repo(git_repo)
  end

  def generate_repo_slug
    self.git_repo = user.github_username + SecureRandom.hex(5)
  end
end
