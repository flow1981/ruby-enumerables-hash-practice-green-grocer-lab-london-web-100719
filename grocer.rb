def consolidate_cart(cart)

  result={}
  
  cart_elements=[]
  element_counter=[]
  
  cart.each do |element|
    cart_elements.push(element.keys)
  end
  
  uniq_elements=cart_elements.uniq
  uniq_elements.each do |uniquat|
     element_counter.push(cart_elements.count(uniquat))
  end

  uniq_elements.each do |element|
    result[element.join('')]={}
  end

  uniq_elements.each do |element|
    cart.each do |item|
      item.each do |name, attributes|
        if name==element[0]
          result[element[0]]=attributes
        end
      end
    end
  end

  result.each do |item, attributes|
    list=uniq_elements.map {|entry| entry.join('')}
    amount = element_counter[list.index(item)]
    result[item][:count]=amount
  end
  
  result
end


def apply_coupons(cart, coupons)
  
  return_hash={}
  
  coupons.map do |coupon|
    cart.map do |cart_itemname, item_hash|
      
      non_discounts = item_hash[:count]%coupon[:num]
      discounts     = (item_hash[:count]/coupon[:num]).floor
      

      item_hash[:count] = item_hash[:count]-discounts*coupon[:num]
      return_hash[cart_itemname]=item_hash

      
      #creates discount hash
      discount_name = cart_itemname +" W/COUPON"
      discount_hash = {:price =>coupon[:cost]/coupon[:num],
                       :clearance => item_hash[:clearance],
                       :count => discounts*coupon[:num]
                      }
    

      return_hash[discount_name] = discount_hash
      puts return_hash
      puts '.'
      
    end
  end
  
  cart=return_hash
  
end


def apply_clearance(cart)
  
  return_hash={}
  
  cart.each do |item, attributes|
    
    attributes.each do |attribute, value|
      if attribute==:clearance&&value=TRUE
        item[:price]=item[:price]*0.8
      end
    end
  end

end

def checkout(cart, coupons)
  # code here
end
