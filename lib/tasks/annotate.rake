namespace :annotate do
  desc "annotate your models!"
  task :models => :environment do |t, args|
    exec "annotate --position before --show-indexes --exclude tests"
  end
end
