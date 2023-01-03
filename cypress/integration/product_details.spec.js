describe('home page', () => {
  beforeEach(() => {
    cy.visit('/')
  })

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  cy.get(".products article").first().click();
  cy.get(".product-detail").should("be.visible");
  cy.get(".product-detail h1").should("have.text", "Scented Blade");

  cy.get(".product-detail img").should("have.attr", "src", "/uploads/product/image/2/plante_2.jpg");
  cy.get(".product-detail .quantity").should("have.text", "\n        18 in stock at \n        $24.99\n      ");
  cy.get(".product-detail .button_to").should("have.text", "\n           Add\n");

  });
})