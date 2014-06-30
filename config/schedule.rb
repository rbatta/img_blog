set :output, '/var/www/apps/img_blog/current/log/custom_deploy_after_migrate.log'

every 20.hours do
  command "echo \"I am running from cron!\""
end