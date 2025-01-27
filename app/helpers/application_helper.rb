module ApplicationHelper

  def active_sale?
    Sale.active.any?
  end
  
end
