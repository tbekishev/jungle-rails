describe('add button', () => {
  beforeEach(() => {
    cy.visit('/')
  })
  it("Click add to cart", () => {
    cy.get(".products article").should("be.visible");
    cy.get(".products article").first().click();
    cy.get(".product-detail .button_to").should("have.text", "\n           Add\n");
    cy.get(".product-detail .button_to").click();
    cy.visit('/')

    cy.contains('Add').first().click({force: true})

    cy.contains('My Cart (1)').should("be.visible");

  });    
})