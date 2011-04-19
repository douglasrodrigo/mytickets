class Ticket < ActiveRecord::Base
  attr_accessible :ticket_id, :description, :revision, :ok

  belongs_to :user

  validates :user_id, :presence => true

  default_scope :order => 'tickets.revision asc'

  def status
    ok ? "ok" : "not ok"
  end
end
