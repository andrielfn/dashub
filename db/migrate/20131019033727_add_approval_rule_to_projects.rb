class AddApprovalRuleToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :approval_emoji, :string, default: ':shipit:', null: false
    add_column :projects, :required_approvals, :integer, default: 2, null: false
  end
end
