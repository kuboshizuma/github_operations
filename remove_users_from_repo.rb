require_relative 'repo_operation'

operation = RepoOperation.new(owner=ENV['OWNER_NAME'], repo_name=ENV['REPO_NAME'])
operation.remove_users_except_admin()
