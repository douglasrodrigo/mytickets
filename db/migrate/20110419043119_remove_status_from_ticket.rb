class RemoveStatusFromTicket < ActiveRecord::Migration
  def self.up
    remove_column :tickets, :status
  end

  def self.down
    add_column :tickets, :status, :string
  end
end
