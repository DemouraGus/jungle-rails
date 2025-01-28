const { INTERNAL } = require("@rails/actioncable")
const configYargs = require("webpack-cli/bin/config/config-yargs")

describe('Jungle App Product Page', () => {
  it('should visit the home page successfully', () => {
    cy.visit('/');

    cy.contains('Welcome to The Jungle');
  });

  it('should be able to see product details upon clicking on the product image', () => {
    cy.visit('/');
    cy.get(':nth-child(1) > a > img').click();
    cy.contains('Scented Blade');
  })
});
