class ProposalsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @proposals = current_user.proposals
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
      redirect_to @proposal, :notice => "Successfully created proposal."
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
      redirect_to @proposal, :notice  => "Successfully updated proposal."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @proposal = current_user.proposals.find(params[:id])
    @proposal.destroy
    redirect_to proposals_url, :notice => "Successfully destroyed proposal."
  end
end
