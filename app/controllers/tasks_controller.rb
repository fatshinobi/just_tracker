class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :continue]

  # GET /tasks
  # GET /tasks.json
  def index
    date_param = params[:date]
    tasks_date = date_param ? Time.parse(date_param) : Time.now
    @tasks = Task.to_date(tasks_date, current_user)
    @task = Task.new
    @current_task = Task.currents(current_user).first
    @statistics = Task.per_categories(current_user)
  end

  def continue
    finish_current_task
    Task.create(
      category: @task.category,
      description: @task.description,
      user: current_user,
      start: Time.now
    )

    redirect_to action: 'index'
  end

  def finish
    finish_current_task
    redirect_to action: 'index'
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.start = Time.now
    @task.user = current_user

    respond_to do |format|
      if @task.save
        format.html { redirect_to action: 'index' }
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
        format.html { redirect_to action: 'index', notice: 'Task was successfully updated.' }
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
      @task = Task.for_user(current_user).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:description, :category_id, :start, :finish)
    end

    def finish_current_task
      @current_task = Task.currents(current_user).first
      return if !@current_task
      @current_task.finish = Time.now
      @current_task.save
    end
end
