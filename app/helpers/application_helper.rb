module ApplicationHelper

  def active_sale
    Sale.active.first
  end

  def active_sale?
    active_sale.present?
  end

end
