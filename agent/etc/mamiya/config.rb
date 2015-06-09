# /etc/mamiya/config.rb

set :storage, {
  type: :s3,
  bucket: 'YOUR-S3-BUCKET-NAME',
  region: 'ap-northeast-1', # set it to your region
  access_key_id: '...',
  secret_access_key: '...',
}

set :serf, {
  agent: {
    bind: "0.0.0.0:7760",
    rpc_addr: "127.0.0.1:7762",
    join: 'YOUR-MASTER-HOST:7760', # set it to your master host
  }
}

set :web, {
  port: 7761,
}

# Where should the application go. :myapp is a Symbol to identify application.
applications[:myapp] = {deploy_to: '/home/app/brickwww'}

# Where should Mamiya store packages, pre-releases temporarily.
set :packages_dir, '/tmp/mamiya/packages'
set :prereleases_dir, '/tmp/mamiya/prereleases'

# And how many you want to keep them?
set :keep_packages, 3
set :keep_prereleases, 3

# Label your agent. Block will be called every time when referencing labels.
# (Recommend to implement thread or timeout for periodically fetch...)
labels do
  %i(app production active)
end
