module ProductsHelper
  PRODUCTS_ON_PROMOTION = [ 1, 2, 4 ]

  def on_promotion?(product)
    PRODUCTS_ON_PROMOTION.include?(product.id)
  end

  def products_on_promotion_ids
    PRODUCTS_ON_PROMOTION
  end

  def promotion_price(product, discount_percentage = 20)
    return nil unless product.price.present?

    discounted_price = product.price * (1 - discount_percentage.to_f / 100)
    discounted_price.round(2)
  end

  def discount_for_product(product)
    case product.id
    when 1 then 30
    when 2 then 25
    when 4 then 15
    else 20
    end
  end

  def promotion_price_custom(product)
    return nil unless product.price.present? && on_promotion?(product)

    discount = discount_for_product(product)
    discounted_price = product.price * (1 - discount.to_f / 100)
    discounted_price.round(2)
  end
end
