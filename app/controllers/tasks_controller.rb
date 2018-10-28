class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :add_user, :remove_user]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:task_id])
    @users = @task.users.all.order('created_at DESC')
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  def add_user
    @task = Task.find(params[:task_id])
    @finished = true
    @user_task = UserTask.new(task: @task, user: current_user, finished: @finished)
    @user_task.save
    # @task.user_tasks.where(user: current_user).first.update({finished: true})
    redirect_to root_path
  end


  def remove_user
    @user = current_user
    task = Task.find(params[:task_id])
    @user.tasks.delete(task) 
    redirect_to root_path
  end

  # def remove_tag
  #   tag = Tag.find(params[:tag_id])
  #   @movie.tags.delete(tag)
  #   redirect_to movies_path
  # end




  # def remove_tag
    # tag = Tag.find(params[:tag_id])
    # @movie.tags.delete(tag)
    # redirect_to movies_path
  # end


  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      #@task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :photo)
    end
end
