var stripe = require('stripe')('pk_test_9wSUa34N9FBzsUeQULRtLMIC00TVV9XSvA');

stripe.tokens.create(
  {
    card: {
      number: '4242424242424242',
      exp_month: 5,
      exp_year: 2021,
      cvc: '314',
    },
  },
  function(err, token) {
      console.log(token);
  }
);