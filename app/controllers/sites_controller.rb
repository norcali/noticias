class SitesController < ApplicationController
  load_and_authorize_resource

  def index
    @sites = Site.all
    if user_signed_in?
      render '_sites'
    else
      render 'home'
    end
  end

  def show
    @site = Site.find(params[:id])
    @user = nil
    User.all.each do |user|
      @user = user if user.email == @site.user_id
    end
    if user_signed_in?
      render 'show'
    else
      render 'show_lindo'
    end
  end

  def agregar
    @site = Site.find(params[:id])
    render "posts/_form"
  end

  def new
    @site = Site.new
    render '_form'
  end

  def edit
    @site = Site.find(params[:id])
    render '_form'
  end

  def create
    @site = Site.new(params[:site])

    respond_to do |format|
      if @site.save
        format.html { redirect_to @site, notice: 'Site was successfully created.' }
        format.json { render json: @site, status: :created, location: @site }
      else
        format.html { render action: "new" }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @site = Site.find(params[:id])

    respond_to do |format|
      if @site.update_attributes(params[:site])
        format.html { redirect_to @site, notice: 'Site was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @site = Site.find(params[:id])
    @site.destroy
    redirect_to sites_path
  end
end
