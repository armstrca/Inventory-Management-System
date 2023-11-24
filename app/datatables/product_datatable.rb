class ProductDatatable < AjaxDatatablesRails::Base
  def view_columns
    @view_columns ||= {
      id: { source: 'Product.id' },
      name: { source: 'Product.name' },
      description: { source: 'Product.description' },
      sku: { source: 'Product.sku' },
      price: { source: 'Product.price' },
      stock_quantity: { source: 'Product.stock_quantity' },
      category: { source: 'Category.name' },
      subcategory: { source: 'Subcategory.name' },
      supplier: { source: 'Supplier.name' }
    }
  end

  def data
    records.map do |product|
      {
        id: product.id,
        name: link_to(product.name, product),
        description: product.description,
        sku: product.sku,
        price: number_with_precision(product.price, precision: 2),
        stock_quantity: product.stock_quantity,
        category: product.category.try(:name),
        subcategory: product.subcategory.try(:name),
        supplier: product.supplier.try(:name)
      }
    end
  end

  private

  def get_raw_records
    Product.includes(:category, :subcategory, :supplier).all
  end

  def search_records
    records.where(filter_query)
  end

  def filter_query
    return nil if params[:search].blank?

    conditions = []

    # Add conditions based on your search requirements
    # For example, if you want to search by product name:
    conditions << "products.name ILIKE :search"
    { search: "%#{params[:search]}%" }
  end
end
