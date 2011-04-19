class TicketsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]

  def new
    @ticket = Ticket.new
    @title = "New ticket"
  end

  def create
    @ticket  = current_user.tickets.build(params[:ticket])
    flash[:success] = "Ticket created!" if @ticket.save
    redirect_to current_user
  end

  def edit
    @ticket = Ticket.find(params[:id])
    @title = "Edit ticket"
  end

  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy
  end

  def show
    @ticket = Ticket.find(params[:id])
    @title = @ticket.ticket_id
  end

  def update
    @ticket = Ticket.find(params[:id])
    if @ticket.update_attributes(params[:ticket])
      flash[:success] = "Ticket updated."
      redirect_to current_user
    else
      @title = "Edit user"
      render 'edit'
    end
  end
end
