class RemoveColumnsFromUsers < ActiveRecord::Migration
  def change
  	change_table :users do |t|
  		t.remove :first_name, :last_name, :gender, :age, :looking_for, :image
  	end
  end
end
