//Documentação: https://www.chaijs.com/guide/styles/
describe('Verifica se os valores são iguais', () => {
    test('Um é gual a um', () => {
        expect("um").toBe("um");
    });

    test('dois mais dois é quatro', () => {
        expect(2 + 2).toBe(4);
    });

    test('dois mais três é maior que quatro', () => {
        expect(2 + 3).toBeGreaterThan(4);
    });
});

import foo from "./foo";
describe('Testa Funções', () => {
    test('Retorno da foo deve ser um', () => {
        expect(foo()).toBe("um");
    })
});