class CreateSslReminderDomains < ActiveRecord::Migration
  def change
    create_table :ssl_reminder_domains do |t|
      t.references :user, index: true
      t.string :name
      t.string :url
      t.string :status
      t.date :expiration_date
      t.boolean :notification_enabled

      t.timestamps
    end
  end
end
