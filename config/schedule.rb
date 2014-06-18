set :output, 'log/crontast.log'

every 15.minutes do
  command "echo \"I am running from cron!\""
end