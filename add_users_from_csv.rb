require_relative 'repo_operation'

operation = RepoOperation.new(owner=ENV['OWNER_NAME'], repo_name=ENV['REPO_NAME'])
operation.add_users_from_csv(path=ARGV[0])


=begin

csv header needs "github" column.
sample as follows.

name,github
test,github_id
test1,github_id_1
test2,github_id_2
test3,github_id_3
test4,github_id_4

=end
