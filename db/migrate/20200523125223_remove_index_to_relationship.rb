class RemoveIndexToRelationship < ActiveRecord::Migration[5.2]
  def change
  	 remove_index :relationships, column: :follower_id, name: "index_relationships_on_follower_id_and_followed_id", unique: true
  end
end
