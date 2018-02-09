# bundle exec rake db:migrate
bundle exec rake db:create db:migrate
bundle exec rake translation:fill
bundle exec whenever --update-crontab

# bundle exec rake quest_location:fill

bundle exec puma -C config/puma.rb
