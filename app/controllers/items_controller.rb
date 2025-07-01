class ItemsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_item, only: %i[ show update destroy ]
  rescue_from ActiveRecord::RecordInvalid, with: :render_422
  rescue_from ActionController::ParameterMissing, with: :render_400
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from StandardError,                with: :render_500
  

  def index
    @items = Item.all
    render json: @items.to_json(
      include: {
        produto: { only: [:nome, :marca] },
        compra:  { only: [:valor_total, :status] }
      }
    )
  end

  def show
    render json: @item.to_json(
      include: {
        produto: { only: [:nome, :marca] },
        compra:  { only: [:valor_total, :status] }
      }
    ), status: :ok, location: @item
  end

  def create
    created_items = params.require(:itens).map do |item_data|
      item_attrs = item_data.require(:item).permit(:compra_id, :produto_id, :quantidade, :valor, :comprado)
      Item.create!(item_attrs)
    end

    render json: created_items, status: :created
  end

  def update
    @item.update!(item_params)
    render json: @item.to_json(
      include: {
        produto: { only: [:nome, :marca] },
        compra:  { only: [:valor_total, :status] }
      }
    ), status: :ok, location: @item
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
