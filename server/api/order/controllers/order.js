'use strict';

const stripe = require('stripe')('YOUR STRIPE KEY');

module.exports = {
    create: async ctx => {
        const {
            address,
            amount,
            product,
            postalCode,
            paymentMethodId,
            city,
        } = ctx.request.body;
        const db_product = await strapi.query('products').findOne({ id: product['id'] });
        if (db_product != null) {

            try {
                await stripe.paymentIntents.create({
                    amount: db_product.price * amount * 100, // Convert cent to Dollar
                    currency: "USD",
                    payment_method: paymentMethodId,
                    confirmation_method: "manual",
                    confirm: true,
                    description: `Order ${new Date()} by ${ctx.state.user.id}`,
                    use_stripe_sdk: true,
                });
                try {
                    const order = await strapi.services.order.create({
                        user: ctx.state.user.id,
                        address,
                        amount,
                        product,
                        postalCode,
                        city,
                        total_price: db_product.price * amount,
                    });
                    console.log(order);
                    return {
                        'status': 200,
                        'message': `New order #${order.id} created successfully!`,
                    };
                } catch (err) {
                    console.log(err);
                    return {
                        'status': 400,
                        'message': "Failed to create order"
                    }
                }
            } catch (err) {
                console.log(err);
                return {
                    'status': err['statusCode'],
                    'message': err['code'],
                }
            }
        }

    },
};