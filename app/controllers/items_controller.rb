class ItemsController < ApplicationController
  before_action :set_item, only: %i[ show update destroy ]
  before_action :set_compra, only: %i[ show update destroy ]
  rescue_from ActiveRecord::RecordInvalid, with: :render_422
  rescue_from ActionController::ParameterMissing, with: :render_400
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from StandardError,                with: :render_500

  def index
    @items = Item.all

    render json: @items
  end

  def show
    render json: @item
  end

  def create
    @item = Item.create!(item_params)
  end

  def update
    @item.update!(item_params)
  end

  def destroy
    @item.destroy!
    head :no_content
  end

  private
    def set_item
      @item = Item.find(params.expect(:id))
    end

    def item_params
      params.expect(item: [ :compra_id, :produto_id, :quantidade, :valor, :comprado ])
    end
end
