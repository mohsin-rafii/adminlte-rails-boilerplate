class CreateJoinTableUserSubscribers < ActiveRecord::Migration[6.0]
  def change
    create_table :user_subscribers do |t|
      t.references :user, null: false, foreign_key: true, index: false
      t.references :subscriber, null: false, foreign_key: { to_table: :users }, index: false
      t.index [:user_id, :subscriber_id], unique: true

      t.timestamps
    end
  end
end
