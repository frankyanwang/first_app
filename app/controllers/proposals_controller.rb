class ProposalsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @proposals = Proposal.all
  end
  
  def my_proposals
    my_proposals = current_user.proposals.includes(:div, :trade_div)
    respond_to do |format|
      # format.html { render "myproposals"}
      format.html { render :partial => "my_proposals", :locals => { :my_proposals => my_proposals }}
      format.json { render :json => my_proposals }
    end    
  end
  
  def proposals_to_me
    proposals_to_me = Proposal.where(:div_id => current_user.divs)
    respond_to do |format|
      # format.html { render "myproposals"}
      format.html { render :partial => "proposals_to_me", :locals => { :proposals_to_me => proposals_to_me }}
      format.json { render :json => proposals_to_me }
    end    
  end
  
  def accept
    @proposal = Proposal.where(:div_id => current_user.divs, :id => params[:id]).first
    if @proposal
      @proposal.status_type = :accept
      if @proposal.save
        redirect_to new_div_url, :notice  => "Accept the proposal."
        # render :nothing => true, :status => :ok  #200
      else
        # render :nothing => true, :status => :internal_server_error #500
        redirect_to new_div_url, :notice  => "Failed to accept proposal, try again."
      end      
    else
        # render :nothing => true, :status => :not_found #404
        redirect_to new_div_url, :notice  => "Failed to accept proposal, try again later."
    end
  end
  
  def reject
    @proposal = Proposal.where(:div_id => current_user.divs, :id => params[:id]).first
    if @proposal
      @proposal.status_type = :reject
      if @proposal.save
        redirect_to new_div_url, :notice  => "Reject the proposal."
        # render :nothing => true, :status => :ok  #200
      else
        redirect_to new_div_url, :notice  => "Failed to reject the proposal, try again."
        # render :nothing => true, :status => :internal_server_error #500
      end      
    else
      redirect_to new_div_url, :notice  => "Failed to reject the proposal, try again later."
        # render :nothing => true, :status => :not_found #404
    end    
  end
  
  def counter
    
  end

  def show
    @proposal = current_user.proposals.find(params[:id])
  end

  def new
    @proposal = Proposal.new
    render :partial => 'new'
  end

  def create
    @proposal = current_user.proposals.build(params[:proposal])
    @proposal.status_type = :pending
    if @proposal.save
      redirect_to feed_timeline_url, :notice => "Successfully created proposal."
    else
      render :action => 'new'
    end
  end

  def edit
    @proposal = current_user.proposals.find(params[:id])
  end

  def update
    @proposal = current_user.proposals.find(params[:id])
    if @proposal.update_attributes(params[:proposal])
      redirect_to new_div_url, :notice  => "Successfully updated proposal."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @proposal = current_user.proposals.find(params[:id])
    @proposal.destroy
    redirect_to new_div_url, :notice => "Successfully destroyed proposal."
  end
end
