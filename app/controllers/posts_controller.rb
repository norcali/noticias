class PostsController < ApplicationController
	load_and_authorize_resource

	def create
	    @site = Site.find(params[:site_id])
	    @post = @site.posts.create(params[:post])
	    @post.user_id = current_user.id
			@post.save
	    redirect_to site_path(@site)
  end

	def edit
		@post = Post.find(params[:id])
		render 'edit'
	end

	def destroy
	    @site = Site.find(params[:site_id])
	    @post = @site.posts.find(params[:id])
	    @post.destroy
	    redirect_to site_path(@site)
  end
  
	def show
    @site = Site.find(params[:site_id])
    @post = @site.posts.find(params[:id])
    if user_signed_in?
    	render 'show'
    else
    	render 'interior'
    end
	end

	def update
    @post = Post.find(params[:id])
    @site = Site.find(@post.site.id)
    @id_site = params[:site_id]

    respond_to do |format|
      	if @post.update_attributes(params[:post])
	        format.html { redirect_to site_path(@site, :id => @id_site), notice: 'Site was successfully updated.' }
	        format.json { head :no_content }
      	else
	        format.html { render action: "edit" }
	        format.json { render json: @site.errors, status: :unprocessable_entity }
      	end
    end
    redirect_to site_site_post_path(@post)
	end

	def my_rescue_method
		redirect_to root_path
	end
end
