set :output, '/var/www/apps/img_blog/current/log/production.log'

every 1.minute do
  command "echo \"I am running from cron!\""
end