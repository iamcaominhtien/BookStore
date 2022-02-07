var cart = {
    init: function () {
        cart.regEvents();
    },
    regEvents: function () {
        $("#btnContinue").off('click').on('click', function () {
            window.location.href = "/";
        });

        $("#btnUpdate").off('click').on('click', function () {
            var listProduct = $('.txtquantity');
            var cartList = [];
            $.each(listProduct, function (i, item) {
                cartList.push({
                    Quantity: $(item).val(),
                    Product: {
                        ID: $(item).data('id')
                    }
                });
            });

            $.ajax({
                url: 'Orders/Update',
                data: { cartModel: JSON.stringify(cartList) },
                dataType: 'json',
                type: 'POST',
                success: function (res) {
                    if (res.status == true) {
                        newprice = $(".total_price_of_product");
                        number_product = $(".txtquantity");
                        count_number_product = 0;
                        for (let i = 0; i < res.data.length - 1; i++) {
                            $(newprice[i]).html(res.data[i])
                        }
                        $("#checkout_product3").html(res.data[res.data.length - 1] + "đ")

                        for (let i = 0; i < number_product.length; i++) {
                            count_number_product = count_number_product + parseInt($(number_product[i]).val());
                        }
                        $("#checkout_product2").html(count_number_product);
                        $("#checkout_product1").html(number_product.length);
                    }
                }
            })
        });

        $("#btnDeleteAll").off('click').on('click', function () {
            $.ajax({
                url: 'Cart/DeleteAll',
                dataType: 'json',
                type: 'POST',
                success: function (res) {
                    if (res.status == true) {
                        window.location.href = '/shopping-cart';
                    }
                }
            })
        });

        $(".icon_close").off('click').on('click', function (e) {
            a = this;
            e.preventDefault();
            $.ajax({
                data: { id: $(this).data('id') },
                url: 'Orders/DeleteItem',
                dataType: 'json',
                type: 'POST',
                success: function (res) {
                    if (res.status == true) {
                        if (res.data != "0") {
                            a.parentElement.parentElement.remove();
                            newprice = $(".total_price_of_product");
                            number_product = $(".txtquantity");
                            count_number_product = 0;

                            //Dien checkout 3 
                            $("#checkout_product3").html(res.data + "đ");

                            //Dien checkout 1 vs 2
                            for (let i = 0; i < number_product.length; i++) {
                                count_number_product = count_number_product + parseInt($(number_product[i]).val());
                            }
                            $("#checkout_product2").html(count_number_product);
                            $("#checkout_product1").html(number_product.length);
                        }
                        else {
                            window.location.href = "/shopping-cart";
                        }
                    }
                }
            })
        });

        $("#btnPayment").off('click').on('click', function () {
            window.location.href = "/shopping-cart";
        });
    }
}

cart.init();