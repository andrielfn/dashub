class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.string :name, null: false
      t.string :description
      t.string :url, null: false


      t.references :project
      t.timestamps
    end

    add_index :repositories, :project_id
  end
end
