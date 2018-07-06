class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  before_action :check_ownership, only: [:destroy]

  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Review.where(user: current_user)
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
    @git_clone_command = "$ git clone " + Git.get_git_url(@review.git_repo)
    @git_add_remote_command = "$ git add remote levelup " + Git.get_git_url(@review.git_repo) +
      "\n$ git push levelup master"
    @invite_url = Git.get_invite_url(@review.git_repo)
  end

  def show_pending
    @reviews = Review.select { |r| r.reviewers.length == 0 }
    render :index
  end

  # GET /reviews/new
  def new
    @review = Review.new
    create
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new
    current_user.reviews << @review

    respond_to do |format|
      if @review.save
        format.html { redirect_to @review }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_review
    @review = Review.find(params[:id])
  end

  def check_ownership
    unless @review.user == current_user
      respond_to do |format|
        format.html { redirect_to reviews_url, notice: "You aren't allowed to do that.", status: :unauthorized}
        format.json { head :no_content, status: :unauthorized }
      end
    end
  end
end
