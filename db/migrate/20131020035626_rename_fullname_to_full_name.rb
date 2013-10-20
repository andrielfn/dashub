class RenameFullnameToFullName < ActiveRecord::Migration
  def change
    rename_column :repositories, :fullname, :full_name
  end
end
