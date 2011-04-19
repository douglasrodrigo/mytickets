class ChangeOkFromTickets < ActiveRecord::Migration
  def self.up
    change_column :tickets, :ok, :boolean, :null => false, :default => false
  end

  def self.down
    change_column :tickets, :ok, :boolean, :null => true
  end
end
