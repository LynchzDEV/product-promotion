module ProductsHelper
  def promotion_config
    @promotion_config ||= begin
      config_file = Rails.root.join("config", "promotions.yml")
      if File.exist?(config_file)
        YAML.load_file(config_file)["promotions"]
      else
        { "enabled" => false, "product_ids" => [], "default_discount" => 20 }
      end
    end
  end

  def on_promotion?(product)
    return false unless promotion_config["enabled"]

    if promotion_config["product_ids"]
      promotion_config["product_ids"].include?(product.id)
    elsif promotion_config["products_with_discounts"]
      promotion_config["products_with_discounts"].key?(product.id)
    else
      false
    end
  end

  def products_on_promotion_ids
    if promotion_config["product_ids"]
      promotion_config["product_ids"]
    elsif promotion_config["products_with_discounts"]
      promotion_config["products_with_discounts"].keys
    else
      []
    end
  end

  def discount_for_product(product)
    if promotion_config["products_with_discounts"] &&
       promotion_config["products_with_discounts"][product.id]
      promotion_config["products_with_discounts"][product.id]
    else
      promotion_config["default_discount"] || 20
    end
  end

  def promotion_price(product, custom_discount = nil)
    return nil unless product.price.present?

    discount = custom_discount || promotion_config["default_discount"] || 20
    discounted_price = product.price * (1 - discount.to_f / 100)
    discounted_price.round(2)
  end

  def promotion_price_custom(product)
    return nil unless product.price.present? && on_promotion?(product)

    discount = discount_for_product(product)
    discounted_price = product.price * (1 - discount.to_f / 100)
    discounted_price.round(2)
  end

  def reload_promotion_config!
    @promotion_config = nil
    promotion_config
  end
end
