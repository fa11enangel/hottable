class BooksController < ApplicationController
  # GET /users
  def index
    @search = Book.ransack(params[:q])
    @search.fields = Book.ransortable_attributes if @search.fields.none?
    @pagy, @records = pagy(@search.result, items: params.fetch(:page_items, 20))
  end

  # GET|POST /users/search
  def search
    index
    redirect_to books_path(params.to_unsafe_hash.except(:authenticity_token, :action, :controller, :commit))
  end
end
