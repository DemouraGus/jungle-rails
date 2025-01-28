const { INTERNAL } = require("@rails/actioncable")
const configYargs = require("webpack-cli/bin/config/config-yargs")

describe('Jungle App Add to Cart', () => {
  it('should visit the home page successfully', () => {
    cy.visit('/');
    cy.contains('Welcome to The Jungle');
  });

  it('should add one item to the cart after clicking the add to cart button', () => {
    cy.visit('/');
    cy.get('.btn').click({ force: true });
    cy.get('.end-0 > .nav-link').contains('1');
  })
});