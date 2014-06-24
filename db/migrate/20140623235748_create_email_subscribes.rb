class CreateEmailSubscribes < ActiveRecord::Migration
  def change
    create_table :email_subscribes do |t|
      t.string :email

      t.timestamps
    end
  end
end
