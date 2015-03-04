namespace :db do
  desc "boostrap db"
  task bootstrap: %i(drop create migrate seed)
end
