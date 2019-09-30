//Documentação: https://github.com/jsdom/jsdom
describe("Mock do DOM", () => {

    var mensagem = 'Deve aparecer a data ao clicar no botão';
    document.body.innerHTML =
        `<!DOCTYPE html>
                <p class="hi">Hello world</p>
                <p id="date">${mensagem}</p>
                <button type="button" onclick="document.getElementById('date').innerHTML = Date()">Click me to display Date and Time.</button >`;

    test("Verifica as propriedades definido no DOM do paragraph", () => {

        var pHi = document.querySelector("p.hi");
        expect(pHi).not.toBeNull;
        expect(pHi.className).toBe('hi');
        expect(pHi.textContent).toBe('Hello world');
    });

    test("Simula a ação de click do botão e verifica se valor alterado é o diferente do original no DOM", () => {

        var pDate = document.querySelector("p#date");
        expect(pDate.textContent).toBe(mensagem);

        var button = document.querySelector("button");
        expect(button).not.toBeNull;

        button.click();
        expect(pDate.textContent).not.toBe(mensagem);
    });
});