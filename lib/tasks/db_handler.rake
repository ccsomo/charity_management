namespace :db_handler do
  desc "Resets database and migrates it"
  task :reset => :environment do
    ["db:drop", "db:create", "db:migrate"].each do |t|
      Rake::Task[t].invoke
    end
  end
end