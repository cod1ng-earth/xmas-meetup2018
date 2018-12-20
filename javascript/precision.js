const a = Math.ceil(10 * (0.2 + 0.1));    //"3"
const b = Math.floor(11.0 * (0.6 + 0.3)); //"9"

console.log(a + b); //13  t(-.-t)

//explanation
console.log (10 * (.2 + .1)) //3.0000000000000004 /ceil -> 4 (!)
console.log (11 * (.6 + .3)) //9.899999999999999 /floor -> 9



