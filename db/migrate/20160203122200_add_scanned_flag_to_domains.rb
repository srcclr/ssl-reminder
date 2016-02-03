class AddScannedFlagToDomains < ActiveRecord::Migration
  def change
    add_column :ssl_reminder_domains, :scanned, :boolean, default: false
  end
end
