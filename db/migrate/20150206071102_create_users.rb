class CreateUsers < ActiveRecord::Migration
  def change
  	create_table :users do |t|
  		t.string   :username
  		t.string   :password_hash
  		t.string   :station
  		t.string   :destination

  		t.timestamps
  	end
  end
end
