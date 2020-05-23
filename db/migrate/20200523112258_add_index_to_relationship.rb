class AddIndexToRelationship < ActiveRecord::Migration[5.2]
  def change
  	
  	 add_index :relationships, [:follower_id, :following_id], unique: true
  	 add_index :relationships, :following_id
  end
end
