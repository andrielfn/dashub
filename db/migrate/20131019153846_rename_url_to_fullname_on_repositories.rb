class RenameUrlToFullnameOnRepositories < ActiveRecord::Migration
  def change
    rename_column :repositories, :url, :fullname
  end
end
