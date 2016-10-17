class AddWorkflowStateToPlaces < ActiveRecord::Migration[5.0]
  def change
    add_column :places, :workflow_state, :string
    add_index :places, :workflow_state
  end
end
