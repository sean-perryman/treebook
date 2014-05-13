class AddStatusesToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :status, index: true
  end
end
