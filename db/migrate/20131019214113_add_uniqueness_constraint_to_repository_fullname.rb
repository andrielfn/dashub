class AddUniquenessConstraintToRepositoryFullname < ActiveRecord::Migration
  def change
    add_index :repositories, [:project_id, :fullname], unique: true
  end
end
