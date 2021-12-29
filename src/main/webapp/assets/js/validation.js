const inputNames = ['numea', 'prenumea'];

let isValid;
let v = new Map();

const validation = () => {
    isValid = true;
    v = new Map();
    inputNames.map(input => {
        v.set(input, document.forms['form'][input].value);
    });

    hideAll();

    check('numea', isStringValid);
    check('prenumea', isStringValid);

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

const hideAll = () => {
    inputNames.map(input => {
        //document.getElementById(input + "1").classList.remove("d");
        //document.getElementById(input + "1").classList.add("dnone");

        document.getElementById(input + "1").classList.replace("d", "dnone");
        document.getElementById(input + "0").classList.replace("d", "dnone");

        //document.getElementById(input + "0").classList.remove("d");
        //document.getElementById(input + "0").classList.add("dnone");
    });
}

const unHide = (id) => {
    //document.getElementById(id).classList.remove("dnone");
    //document.getElementById(id).classList.add("d");

    document.getElementById(id).classList.replace("dnone", "d");
}

const isStringValid = (name) => {
    return /^[A-Za-z-. ]+$/.test(name);
}