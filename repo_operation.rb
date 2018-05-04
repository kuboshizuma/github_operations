require 'dotenv'
require 'octokit'

Dotenv.load

class RepoOperation
  def initialize(owner, repo_name)
    @owner = owner
    @repo_name = repo_name

    Octokit.auto_paginate = true
    @client = Octokit::Client.new(access_token: ENV['GITHUB_ACCESS_TOKEN'])
  end

  def fetch_users()
    res = @client.collaborators(@repo_name)
    user_num = 0
    res.each do |user|
      puts user[:login]
      user_num += 1
    end
    puts "finished! user num: #{user_num}"
  end

  def fetch_admin_users()
    res = @client.collaborators(@repo_name)
    user_num = 0
    res.each do |user|
      if user[:permissions][:admin] == true
        puts user[:login]
        user_num += 1
      end
    end
    puts "finished! admin user num: #{user_num}"
  end

  def remove_users_except_admin()
    res = @client.collaborators(@repo_name)
    user_num = 0
    res.each do |user|
      if user[:permissions][:admin] == false
        if @client.remove_collaborator(@repo_name, user[:login])
          user_num += 1
          puts "Remove #{user[:login]} from repository."
        end
      end
    end
    puts "finished! remove user num: #{user_num}"
  end
end
