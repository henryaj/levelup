require 'git'
require 'securerandom'

class Review < ApplicationRecord
  has_and_belongs_to_many :users
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'

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
