class AddApprovalRuleToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :approval_emoji, :string
    add_column :projects, :required_approvals, :integer
  end
end
