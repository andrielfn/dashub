class AddApprovalRuleToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :approval_rule, :string
  end
end
