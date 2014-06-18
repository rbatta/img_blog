set :output, '/var/www/apps/imageblog/current/log/crontask.log'

every 15.minutes do
  command "echo \"I am running from cron!\""
end