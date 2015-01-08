set :output, '/var/www/apps/img_blog/current/log/custom_deploy_after_migrate.log'

every 1.day do
  command "echo \"I am running from cron!\""
end

every 30.minutes do
  rake "db:populate"
end