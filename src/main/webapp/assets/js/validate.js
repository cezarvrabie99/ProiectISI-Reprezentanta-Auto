const inputAngajati = ['numea', 'prenumea', 'cnp', 'adresaa', 'telefona', 'emaila', 'localitate', 'judet', 'tara'];
const inputClienti = ['numec', 'prenumec', 'cnp', 'adresac', 'telefonc', 'emailc', 'localitate', 'judet', 'tara'];
const inputFunctii = ['denf', 'salariubrut', 'salariunet'];
const inputPiese = ['codp', 'denp', 'pretp', 'pretptva'];
const inputService = ['conbop', 'vin', 'prod'];
const inputVanzare = ['prod', 'pret', 'prettva', 'conbop'];
const inputUtilizatori = ['username'];
const inputAuto = ['vin', 'data_fab', 'preta', 'pretatva', 'stoc'];

const countries = ['AF','AX','AL','DZ','AS','AD','AO','AI','AQ','AG','AR','AM','AW','AU','AT','AZ','BS','BH',
    'BD','BB','BY','BE','BZ','BJ','BM','BT','BO','BQ','BA','BW','BV','BR','IO','BN','BG','BF','BI','KH','CM','CA','CV',
    'KY','CF','TD','CL','CN','CX','CC','CO','KM','CG','CD','CK','CR','CI','HR','CU','CW','CY','CZ','DK','DJ','DM','DO',
    'EC','EG','SV','GQ','ER','EE','ET','FK','FO','FJ','FI','FR','GF','PF','TF','GA','GM','GE','DE','GH','GI','GR','GL',
    'GD','GP','GU','GT','GG','GN','GW','GY','HT','HM','VA','HN','HK','HU','IS','IN','ID','IR','IQ','IE','IM','IL','IT',
    'JM','JP','JE','JO','KZ','KE','KI','KP','KR','XK','KW','KG','LA','LV','LB','LS','LR','LY','LI','LT','LU','MO','MK',
    'MG','MW','MY','MV','ML','MT','MH','MQ','MR','MU','YT','MX','FM','MD','MC','MN','ME','MS','MA','MZ','MM','NA','NR',
    'NP','NL','AN','NC','NZ','NI','NE','NG','NU','NF','MP','NO','OM','PK','PW','PS','PA','PG','PY','PE','PH','PN','PL',
    'PT','PR','QA','RE','RO','RU','RW','BL','SH','KN','LC','MF','PM','VC','WS','SM','ST','SA','SN','RS','CS','SC','SL',
    'SG','SX','SK','SI','SB','SO','ZA','GS','SS','ES','LK','SD','SR','SJ','SZ','SE','CH','SY','TW','TJ','TZ','TH','TL',
    'TG','TK','TO','TT','TN','TR','TM','TC','TV','UG','UA','AE','GB','US','UM','UY','UZ','VU','VE','VN','VG','VI','WF',
    'EH','YE','ZM','ZW'];
const judete = ['AB', 'AG', 'AR', 'B', 'BC', 'BH', 'BN', 'BR', 'BT', 'BV', 'BZ', 'CJ', 'CL', 'CS', 'CT',
    'CV', 'DB', 'DJ', 'GJ', 'GL', 'GR', 'HD', 'HR', 'IF', 'IL', 'IS', 'MH', 'MM', 'MS', 'NT', 'OT', 'PH',
    'SB', 'SJ', 'SM', 'SV', 'TL', 'TM', 'TR', 'VL', 'VN', 'VS'];

let isValid;
let v = new Map();

const validate = (form) => {
    isValid = true;
    v = new Map();

    switch (form){
        case "angajati":
            inputAngajati.map(input => {
                v.set(input, document.forms['form'][input].value);
            });
            hideAll(inputAngajati);
            check('numea', isStringValid);
            check('prenumea', isStringValid);
            check('cnp', isCNPValid);
            check('adresaa', isAddressValid);
            check('telefona', isNumberValid);
            check('emaila', isEmailValid);
            check('localitate', isStringValid);
            check('judet', isJudetValid);
            check('tara', isCountryCodeValid);
            break;
        case "auto":
            inputAuto.map(input => {
                v.set(input, document.forms['form'][input].value);
            });
            console.log(v);
            hideAll(inputAuto);
            check('vin', isVINValid);
            check('data_fab', isDataFabValid);
            check('preta', isNumber);
            check('pretatva', isNumber);
            check('stoc', isNumber);
            break;
        case "clienti":
            inputClienti.map(input => {
                v.set(input, document.forms['form'][input].value);
            });
            hideAll(inputClienti);
            check('numec', isStringValid);
            check('prenumec', isStringValid);
            check('cnp', isCNPValid);
            check('adresac', isAddressValid);
            check('telefonc', isNumberValid);
            check('emailc', isEmailValid);
            check('localitate', isStringValid);
            check('judet', isJudetValid);
            check('tara', isCountryCodeValid);
            break;
        case "functii":
            inputFunctii.map(input => {
                v.set(input, document.forms['form'][input].value);
            });
            hideAll(inputFunctii);
            check('denf', isStringValid);
            check('salariubrut', isNumber);
            check('salariunet', isNumber);
            break;
        case "piese":
            inputPiese.map(input => {
                v.set(input, document.forms['form'][input].value);
            });
            hideAll(inputPiese);
            check('codp', isAddressValid);
            check('denp', isStringValid);
            check('pretp', isNumber);
            check('pretptva', isNumber);
            break;
        case "service":
            inputService.map(input => {
                v.set(input, document.forms['form'][input].value);
            });
            hideAll(inputService);
            check('conbop', isSelected);
            check('vin', isVINValid);
            check('prod', isSelected);
            break;
        case "utilizatori":
            inputUtilizatori.map(input => {
                v.set(input, document.forms['form'][input].value);
            });
            hideAll(inputUtilizatori);
            check('username', isStringValid);
            if (document.forms['form']['password'].value !== document.forms['form']['password2'].value){
                unHide('password20');
                isValid = false;
            } else
                unHide('password21');
            break;
        case "vanzare":
            inputVanzare.map(input => {
                v.set(input, document.forms['form'][input].value);
            });
            hideAll(inputVanzare);
            check('prod', isAddressValid);
            check('pret', isNumber);
            check('prettva', isNumber);
            check('conbop', isSelected);
            break;
    }

    return isValid;
}

const check = (id, paramFunction) => {
    if (paramFunction((v.get(id))))
        unHide(id + '1');
    else {
        unHide(id + '0');
        isValid = false;
    }
}

const hideAll = (inputs) => {
    inputs.map(input => {
        document.getElementById(input + "1").className = "dnone";
        document.getElementById(input + "0").className = "dnone";

    });
}

const unHide = (id) => {
    document.getElementById(id).className = "d";
}

const isStringValid = (name) => {
    return /^[A-Za-z-. ]+$/.test(name);
}

const getControlDigit = (first12) => {
    let number = 0;
    const controlDigits = "279146358279";

    for (let i = 0; i < 12; i++){
        number += first12.substring(i, i+1) * controlDigits.substring(i, i+1);
    }

    return number % 11;
}

const y2k = (number) => {
    return (number < 1000) ? number + 1900 : number;
}

const isDateValid = (yymmdd) => {
    if (yymmdd.length !== 6)
        return false;
    if (yymmdd !== ((yymmdd - 0) + ''))
        return false;

    let year = yymmdd.substring(0, 2) - 0;
    let month = yymmdd.substring(2, 4) - 1;
    let day = yymmdd.substring(4, 6) - 0;

    (year < 70) ? year += 2000: year += 1900;

    const test = new Date(year,month,day);

    return (y2k(test.getYear()) === year) &&
        (month === test.getMonth()) &&
        (day === test.getDate());
}

const isCNPValid = (cnp) => {
    if (cnp.length === 13 && /^[0-9]+$/.test(cnp)) {
        const firstDigit = cnp.charAt(0);
        const date = cnp.substring(1, 7);
        const lastDigit = cnp.substring(12, 13);
        const first12Digits = cnp.substring(0, 12);

        if (firstDigit !== "0" && isDateValid(date)) {
            let controlDigit = getControlDigit(first12Digits);
            if (controlDigit === 10)
                controlDigit = 1;
            return controlDigit === parseInt(lastDigit);
        } else
            return false;
    } else
        return false;
}

const isEmailValid = (email) => {
    return /^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$/.test(email);
}

const isCountryCodeValid = (code) => {
    return countries.includes(code);
}

const isAddressValid = (address) => {
    return /^[A-Za-z0-9-.& ]+$/.test(address);
}

const isNumberValid = (number) => {
    return (number.length === 10 && /^[0-9]*$/.test(number)) || (number.length === 12 && /^[0-9+]*$/.test(number))
}

const isJudetValid = (judet) => {
    return judete.includes(judet);
}

const isNumber = (number) => {
    return !isNaN(number) && number.length > 0 && number > 0;
}

const isSelected = (val) => {
    return val.length > 0 && !val.toLowerCase().includes("selecteaza");
}

const isVINValid = (vin) => {
    if (vin.length !==17)
        return false;
    vin = vin.toUpperCase();

    return (vin.startsWith("5YJ") || vin.startsWith("7SA") || vin.startsWith("LRW") || vin.startsWith("SFZ"))
        && !vin.includes("I") && !vin.includes("Q") && !vin.includes("O")
        && (vin[3] === "S" || vin[3] === "3" || vin[3] === "X" || vin[3] === "Y" || vin[3] === "R")
        && (vin[4] >= "A" && vin[4] <= "G")
        && ((vin[5] >= "1" && vin[5] <= "8") || (vin[5] >= "A" && vin[5] <= "D"))
        && ((vin[6] >= "A" && vin[6] <= "F") || vin[6] >= "H" || vin[6] >= "S" || vin[6] >= "V" || vin[6] >= "1")
        && ((vin[7] >= "1" && vin[7] <= "6") || (vin[7] >= "A" && vin[7] <= "G") || (vin[7] >= "J" && vin[7] <= "L") || vin[7] === "N" || vin[7] === "P")
        && ((vin[9] >= "6" && vin[9] <= "9") || (vin[9] >= "A" && vin[9] <= "H") || (vin[9] >= "J" && vin[9] <= "R"))
        && (vin[10] === "1" || vin[10] === "3" || vin[10] === "A" || vin[10] === "C" || vin[10] === "F" || vin[10] === "G" || vin[10] === "P" || vin[10] === "R")
        && ((vin[11] >= "0" && vin[11] <= "9") || vin[11] === "A" || vin[11] === "B" || vin[11] === "E" || vin[11] === "F" || vin[11] === "M" || vin[11] === "P" || vin[11] === "R" || vin[11] === "S" || vin[11] === "V")
        && (vin[12] >= "0" && vin[12] <= "9");
}

const isDataFabValid = (date) => {
    let todaysDate = new Date();
    let year = todaysDate.getFullYear();
    let month = ("0" + (todaysDate.getMonth() + 1)).slice(-2);
    let day = ("0" + todaysDate.getDate()).slice(-2);
    let maxDate = (year +"-"+ month +"-"+ day);

    return date <= maxDate && (new Date(date) !== "Invalid Date") && !isNaN(new Date(date));
}