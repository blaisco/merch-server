namespace :db do
  desc "Remove all data from database (excluding migrations); keeps structure"
  task :truncate => :environment do |t, args|
    require 'database_cleaner'
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
  end
end
