class AddOkToTicket < ActiveRecord::Migration
  def self.up
    add_column :tickets, :ok, :boolean
  end

  def self.down
    remove_column :tickets, :ok
  end
end
