class AddProviderTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :provider_token, :string
    add_column :users, :provider_token_expires, :string
  end
end
