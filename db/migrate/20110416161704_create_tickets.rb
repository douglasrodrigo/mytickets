class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      t.integer :ticket_id
      t.text :description
      t.datetime :revision
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :tickets
  end
end
