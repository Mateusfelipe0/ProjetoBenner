import { mount } from '@vue/test-utils'
import hello from "../../components/example/Hello.vue";

describe('Testa vue', () => {
    const wrapper = mount(hello)

    test('Espera-se que o data greeting do componente seja Hello', () => {
        expect(wrapper.vm.$data.greeting).toBe('Hello');
    })
})
