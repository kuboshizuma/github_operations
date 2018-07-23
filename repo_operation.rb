require 'dotenv'
require 'octokit'
require 'csv'

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

  def fetch_organization_team(org=ENV['ORGANIZATION_NAME'], team_name=ENV['TEAM_NAME'])
    res = @client.organization_teams(org)
    team = res.select {|team| team[:name] == team_name}
    return team[0]
  end

  def invite_users_to_org_from_csv(path, skip=0, header=true)
    csv_data = CSV.read(File.expand_path('./data/' + path), headers: header)
    team_id = fetch_organization_team()[:id]
    user_num = 0
    csv_data.each_with_index do |user, i|
      next if i < skip
      begin
        @client.update_organization_membership(ENV['ORGANIZATION_NAME'], {user: user['github'], state: 'active', role: 'member'})
        @client.add_team_membership(team_id, user['github'])
        user_num += 1
        puts "Add #{user['github']} to repository."
      rescue => e
        puts "Error has occured for #{user['github']}.: #{e}"
      end
    end
    puts "finished! invite users to #{ENV['ORGANIZATION_NAME']}: #{user_num}"
  end

  def add_users_from_csv(path, skip=0, header=true)
    csv_data = CSV.read(File.expand_path('./data/' + path), headers: header)
    user_num = 0
    csv_data.each_with_index do |user, i|
      next if i < skip
      begin
        @client.add_collaborator(@repo_name, user['github'])
        user_num += 1
        puts "Add #{user['github']} to repository."
      rescue => e
        puts "Error has occured for #{user['github']}.: #{e}"
      end
    end
    puts "finished! add users num: #{user_num}"
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
