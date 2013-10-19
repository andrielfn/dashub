class AddApprovalRuleToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :approval_emoji, :string
    add_column :projects, :emoji_count, :integer
  end
end
