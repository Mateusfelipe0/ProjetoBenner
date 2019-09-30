describe('Teste Calendar.js', () => {

    test('Verificando se a data é válida', () => {
        
        let validDate = Date.isValidDate(9, 1, 1991);
        expect(validDate).toBeTruthy();

        validDate = Date.isValidDate(35, 1, 1991);
        expect(validDate).toBeFalsy();

        validDate = Date.isValidDate(9, 13, 1991);
        expect(validDate).toBeFalsy();

        validDate = Date.isValidDate(9, 1, 1);
        expect(validDate).toBeFalsy();
    })

    test('Valida a conversao de tipo date para string no formato DD/MM/YYYY', () => {
        let date = new Date(1989, 9, 30);
        let dateFormat = Date.toDDMMYYYY(date);
        expect(dateFormat).toBe("30/10/1989");
    })

    test('Validando metodos auxiliares para adicionar dia/mes/ano/hora/minuto/segundo', () => {
        let dateExpect = new Date(2000, 1, 2);
        let resultDate = new Date(2000, 1, 1);
        resultDate.addDays(1);
        expect(resultDate).toEqual(dateExpect);

        dateExpect = new Date(2000, 3, 2);
        resultDate.addMonths(2);
        expect(resultDate).toEqual(dateExpect);

        dateExpect = new Date(2010, 3, 2);
        resultDate.addYears(10);
        expect(resultDate).toEqual(dateExpect);
        
        dateExpect = new Date(2010, 3, 2, 1, 0, 0, 0);
        resultDate.addMilliseconds(3600000);
        expect(resultDate).toEqual(dateExpect);
    })

    test('Validando formatação de campo texto em data', () => {
        let dateString = "30101989"

        let dateFormat = Date.formatDayMonthYear(dateString, "/");
        expect(dateFormat).toBe("30/10/1989");

        dateFormat = Date.formatDayMonthYear(dateString, "-");
        expect(dateFormat).toBe("30-10-1989");

        dateString = "30/101989"
        dateFormat = Date.formatDayMonthYear(dateString, "/");
        expect(dateFormat).toBe("30/10/1989");

        dateFormat = Date.formatDayMonthYear("1", "/");
        expect(dateFormat).toBe("01/" + Date.getCurrentMonth() + "/" + Date.getCurrentYear());

        let monthYearString = "031992";
        let monthYearFormat = Date.formatMonthYear(monthYearString, "/");
        expect(monthYearFormat).toBe("03/1992");
    })

    test('Validando formatação de campo texto em hora', () => {
        let timeString = "1015";
        let timeFormat = Date.formatHourMinute(timeString, ":");
        expect(timeFormat).toBe("10:15");

        timeString = "10";
        timeFormat = Date.formatHourMinute(timeString, ":");
        expect(timeFormat).toBe("10:00");

        timeString = "2";
        timeFormat = Date.formatHourMinute(timeString, ":");
        expect(timeFormat).toBe("02:00");

        timeString = "112550";
        timeFormat = Date.formatHourMinuteSecond(timeString);
        expect(timeFormat).toBe("11:25:50");

        timeString = "11";
        timeFormat = Date.formatHourMinuteSecond(timeString);
        expect(timeFormat).toBe("11:00:00");
    })
});