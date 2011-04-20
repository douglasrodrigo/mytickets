class Ticket < ActiveRecord::Base
  attr_accessible :ticket_id, :description, :revision, :ok

  belongs_to :user

  validates_presence_of :user_id, :ticket_id, :description, :revision

  default_scope :order => 'tickets.revision asc'

  def status
    ok ? "ok" : "not ok"
  end
end
