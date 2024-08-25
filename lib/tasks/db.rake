namespace :db do
  desc "Create missing translations"
  task create_missing_translations: :environment do
    CreateMissingTranslationsService.new.call
  end
end

Rake::Task["db:fixtures:load"].enhance do
  Rake::Task["db:create_missing_translations"].execute
end
