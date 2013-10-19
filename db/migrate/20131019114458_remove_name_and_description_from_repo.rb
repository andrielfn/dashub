class RemoveNameAndDescriptionFromRepo < ActiveRecord::Migration
  def change
    remove_column :repositories, :name
    remove_column :repositories, :description
  end
end
