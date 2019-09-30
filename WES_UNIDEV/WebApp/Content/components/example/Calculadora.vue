<template>
  <div class="container">
    <div class="calculator">
      <div class="display prev">{{ calculator.previous || '' }} {{ calculator.sign }}</div>
      <div class="display result">{{ calculator.current || '0' }}</div>
      <div @click="clearAll" class="btn operator clear">C</div>
      <div @click="division" class="btn operator">/</div>
      <div @click="append('7')" class="btn">7</div>
      <div @click="append('8')" class="btn">8</div>
      <div @click="append('9')" class="btn">9</div>
      <div @click="multiplication" class="btn operator">*</div>
      <div @click="append('4')" class="btn">4</div>
      <div @click="append('5')" class="btn">5</div>
      <div @click="append('6')" class="btn">6</div>
      <div @click="subtraction" class="btn operator">-</div>
      <div @click="append('1')" class="btn">1</div>
      <div @click="append('2')" class="btn">2</div>
      <div @click="append('3')" class="btn">3</div>
      <div @click="sum" class="btn operator">+</div>
      <div class="btn"></div>
      <div @click="append('0')" class="btn">0</div>
      <div class="btn"></div>
      <div @click="equal" class="btn operator">=</div>
    </div>
  </div>
</template>

<script>
module.exports = {
  data: function () {
    return {
      calculator: {
        previous: null,
        current: '',
        operator: null,
        sign: ''
      }
    }
  },
  methods: {
    clearAll() {
      this.calculator.current = ''
    },
    append(number) {
      if(number == '0' && this.calculator.current == '') {
        this.calculator.current = ''
      } else {
        if(this.calculator.operatorClicked) {
          this.calculator.current = ''
          this.calculator.operatorClicked = false
        }
        this.calculator.current = `${this.calculator.current}${number}`
      }
    },
    setPrevious() {
      this.calculator.previous = this.calculator.current;
      this.calculator.operatorClicked = true;
    },
    division() {
      this.calculator.operator = (a, b) => a / b;
      this.setPrevious();
      this.calculator.sign = '/';
    },
    multiplication() {
      this.calculator.operator = (a, b) => a * b;
      this.setPrevious();
      this.calculator.sign = '*';
    },
    subtraction() {
      this.calculator.operator = (a, b) => a - b;
      this.setPrevious();
      this.calculator.sign = '-';
    },
    sum() {
      this.calculator.operator = (a, b) => a + b;
      this.setPrevious();
      this.calculator.sign = '+';
    },
    equal() {
      this.calculator.current = this.calculator.operator(
        parseFloat(this.calculator.previous),
        parseFloat(this.calculator.current)
      )
      this.calculator.previous = null;
      this.calculator.operatorClicked = true; 
      this.calculator.sign = '';
    }
  }
}
</script>

<style scoped>

.calculator {
  margin: 0 auto;
  width: 250px;
  height: 350px;
  text-align: center;
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  grid-auto-rows: minmax(30px, auto);
  box-shadow: 5px 10px 8px #888888;
}

.display {
  align-items: center;
  background-color: #333;
  color: #fff;
  display: flex;
  grid-column: 1 / 5;
  justify-content: flex-end;
}

.result {
  font-size: 25px;
  line-height: 1.9;
  padding: 2px;
}

.prev {
  border-bottom: 1px solid #eee;
}

.clear {
  grid-column: 1 / 4;
}

.btn {
  align-items: center;
  border: 1px solid black;
  display: flex;
  justify-content: center;
}

.btn:hover { 
  background-color: rgb(33.8%, 86.6%, 50.5%); 
  cursor: pointer; 
}

.operator { 
  background-color: rgb(32.1%, 50.5%, 81.6%) 
}

.operator:hover { 
  background-color: rgb(21.9%, 37.6%, 64%); 
  cursor: pointer; 
}

</style>