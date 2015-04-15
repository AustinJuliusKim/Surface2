class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :age
      t.string :gender
      t.string :looking_for

      t.timestamps null: false
    end
  end
end
