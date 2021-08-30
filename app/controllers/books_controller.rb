class BooksController < ApplicationController

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
     redirect_to book_path(@book), notice: 'You have created book successfully.'
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def index
    @books = Book.all
    @user = current_user
    @book= Book.new
  end

  def show
    @book = Book.find(params[:id])
    @bookc = Book.new
    @user = @book.user
    @book_comment = BookComment.new

  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
     render :edit
    else
     redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
     redirect_to book_path(@book.id),  notice: 'You have update book successfully.'
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title,:body)
  end
end

