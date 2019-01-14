class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    # @articles = Article.all # get all articles from the database
    # @articles = Article.paginate(page: params[:page], per_page: 5)
    # @articles = @articles.paginate(page: params[:page], per_page: 5)

    if params[:search]
      @articles = Article.search(params[:search]).paginate(page: params[:page], per_page: 12)
    else
      @articles = Article.paginate(page: params[:page], per_page: 12)
    end
  end


  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id]) # find 'id' from the params hash
  end

#   def self.search(search)
#   if search
#     find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
#   else
#     find(:all)
#   end
# end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "Article was created successfully"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end

    def show
      @article = Article.find(params[:id]) # find 'id' from the params hash
    end

    def search
      @article = Article.new_from_lookup(params[:stock])
      redirect_to article_path(@article)
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:danger] = "Article was successfully deleted"
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, category_ids: [])
  end

  def require_same_user
    if current_user != @article.user and !current_user.admin?
      flash[:danger] = "You can only edit or delete your own articles!"
      redirect_to root_path
    end
  end

end
