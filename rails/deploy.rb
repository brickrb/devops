set :application, 'brick_www'

# Using for package build
set :exclude_from_package, ['tmp', 'log', 'spec', '.sass-cache']
set :dereference_symlinks, true
set :build_from, "/tmp/build_from"
set :build_to, "./builds"
# set :package_under, 'dir'

# You may use helpers here
#  set :repository, '...'
#  use :git, exclude_git_clean_targets: true

# Procedure for build
build 'write built at' do
  # build something...
  File.write('built_at', "#{Time.now}\n")
end

# Step `prepare` on agents,
prepare 'write prepared_at' do
  File.write release_path.join('prepared_at'), Time.now
end

# You can declare multiples. Run by order defined.
prepare 'bundle stuff' do
  run 'bundle', 'install'
end

# Step `release` run when Release is required. Usually for restarting app process, etc.
# Also these step declaration accepts labels for `only` and `except` key to limit agents to run on.
# (Labels can be set by agent's configuration)
release 'reload unicorn', only [:app] do
  run 'pkill', '-HUP', '-f', 'unicorn'
end
