$("[name='shopping_cart[product_instances][combination]']").on('change', function(){
  row_node = this.closest('[data-product-instance]')
  object_id = row_node.dataset["productInstance"]
  $.ajax({
    url: "/product_instances/"+ object_id +"/set_combination",
    data: { combination_id: this.value },
    dataType: 'json'
  }).done(function(data) {
    if(data != undefined) {
      row_node.querySelector('input#shopping_cart_product_instances_total_value').value = data['total_value']
      $('#shopping_cart_total_value').val(data['shopping_cart']['total_value'])
    }
    if(Object.keys(data.errors).length > 0){
      console.log(data.errors)
      // $('#product_instance-'+object_id+'-'+attribute+'-error').text(data.errors[attribute][0])
    }
  });
})

$("[name='shopping_cart[product_instances][quantity]']").on('change', function(){
  row_node = this.closest('[data-product-instance]')
  object_id = row_node.dataset["productInstance"]
  $.ajax({
    url: "/product_instances/"+ object_id +"/set_quantity",
    data: { quantity: this.value },
    dataType: 'json'
  }).done(function(data) {
    if(data != undefined) {
      row_node.querySelector('input#shopping_cart_product_instances_total_value').value = data['total_value']
      $('#shopping_cart_total_value').val(data['shopping_cart']['total_value'])
    }
    if(Object.keys(data.errors).length > 0){
      console.log(data.errors)
      // $('#product_instance-'+object_id+'-'+attribute+'-error').text(data.errors[attribute][0])
    }
  });
})