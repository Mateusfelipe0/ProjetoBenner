import { mount } from '@vue/test-utils'
import calculadora from "../../components/example/Calculadora.vue";

describe('Testa Calculadora.vue.test', () => {
    const wrapper = mount(calculadora)

    test('Testando a soma de valores', () => {
        wrapper.vm.append(5);
        wrapper.vm.sum();
        wrapper.vm.append(5);
        wrapper.vm.equal();

        expect(wrapper.vm.calculator.current).toBe(10);

        wrapper.vm.append(25);
        wrapper.vm.sum();
        wrapper.vm.append(50);
        wrapper.vm.equal();

        expect(wrapper.vm.calculator.current).toBe(75);
    });

    test('Testando a subtração de valores', () => {
        wrapper.vm.append(5);
        wrapper.vm.subtraction();
        wrapper.vm.append(5);
        wrapper.vm.equal();

        expect(wrapper.vm.calculator.current).toBe(0);

        wrapper.vm.append(15);
        wrapper.vm.subtraction();
        wrapper.vm.append(5);
        wrapper.vm.equal();

        expect(wrapper.vm.calculator.current).toBe(10);
    });

    test('Testando a multiplicação de valores', () => {
        wrapper.vm.append(5);
        wrapper.vm.multiplication();
        wrapper.vm.append(5);
        wrapper.vm.equal();

        expect(wrapper.vm.calculator.current).toBe(25);

        wrapper.vm.append(10);
        wrapper.vm.multiplication();
        wrapper.vm.append(2);
        wrapper.vm.equal();

        expect(wrapper.vm.calculator.current).toBe(20);
    });

    test('Testando a divisão de valores', () => {
        wrapper.vm.append(15);
        wrapper.vm.division();
        wrapper.vm.append(5);
        wrapper.vm.equal();

        expect(wrapper.vm.calculator.current).toBe(3);

        wrapper.vm.append(10);
        wrapper.vm.division();
        wrapper.vm.append(2);
        wrapper.vm.equal();

        expect(wrapper.vm.calculator.current).toBe(5);
    });
});